//
//  DeepLinkManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 18/2/2021.
//

import Foundation
import FirebaseDynamicLinks

protocol DeepLinkManagerProtocol {
    func handleDynamicLink(_ link: URL) -> Bool
}

class DeepLinkManager: DeepLinkManagerProtocol {

    private let dynamicLink: DynamicLinksProtocol
    private let errorHandler: ErrorHandlerProtocol
    private let authManager: AuthManagerProtocol
    private let deepLinkRouter: DeepLinkRouterProtocol

    enum DeepLinkType: Equatable {
        case passwordlessSignIn
    }

    init(
        dynamicLink: DynamicLinksProtocol,
        errorHandler: ErrorHandlerProtocol,
        authManager: AuthManagerProtocol,
        deepLinkRouter: DeepLinkRouterProtocol
    ) {
        self.dynamicLink = dynamicLink
        self.errorHandler = errorHandler
        self.authManager = authManager
        self.deepLinkRouter = deepLinkRouter
    }

    func handleDynamicLink(_ link: URL) -> Bool {
        Console.log(type: .warning, "Fuck off ")
        if link.host == "notys.page.link" {
            handleIncomingUniversalLink(link)
            return true
        }
        return dynamicLink.handleUniversalLink(link) { [weak self] _, error in
            guard error == nil else {
                self?.errorHandler.handle(DeepLinkError.caseNotSupported)
                return
            }
            self?.handleIncomingDynamicLink(link)
        }
    }
}

private extension DeepLinkManager {

    func handleIncomingDynamicLink(_ url: URL) {
        let components = url.pathComponents
        do {
            let host = try parseComponents(components: components)
            switch host {
            case .passwordlessSignIn: handleSignIn(with: url)
            }
        } catch {
            errorHandler.handle(error)
        }
    }

    func parseComponents(components: [String]) throws -> DeepLinkType {
        guard components.count >= 2 else {
            throw DeepLinkError.wrongFormat
        }
        let host = components[2]
        switch host {
        case "auth": return .passwordlessSignIn
        default: throw DeepLinkError.caseNotSupported
        }
    }

    func handleIncomingUniversalLink(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        guard let newLink = components.queryItems?[0].value else { return }
        guard let newURL = URL(string: newLink) else { return }
        handleIncomingDynamicLink(newURL)
    }

    func handleSignIn(with link: URL) {
        authManager.confirmSignIn(with: link.absoluteString) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success: self.deepLinkRouter.route(to: .language)
            case .failure(let error): self.errorHandler.handle(error)
            }
        }
    }
}
