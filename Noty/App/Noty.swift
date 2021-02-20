//
//  Noty.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration
import FirebaseDynamicLinks

protocol NotyProtocol {
    func prepare()
    func handleDeepLink(_ link: URL) -> Bool
    func dynamicLink(fromCustomSchemeURL url: URL) -> DynamicLink?
    func handleUniversalLink(_ url: URL) -> Bool
}

class Noty: NotyProtocol {
    private let sharedContainer: Container
    private let sharedAssembly: Assembly
    private let rootNavigator: RootNavigatorProtocol
    private let deepLinkManagerProtocol: DeepLinkManagerProtocol

    init(
        sharedAssembly: Assembly,
        sharedContainer: Container
    ) {
        self.sharedAssembly = sharedAssembly
        self.sharedContainer = sharedContainer
        sharedAssembly.assemble(container: self.sharedContainer)
        rootNavigator = sharedContainer ~> RootNavigatorProtocol.self
        deepLinkManagerProtocol = sharedContainer ~> DeepLinkManagerProtocol.self
    }

    convenience init() {
        let sharedAssembly = SharedAssembly()
        self.init(
            sharedAssembly: sharedAssembly,
            sharedContainer: sharedAssembly.sharedContainer)
    }

    func prepare() {
        rootNavigator.setRootViewController()
    }

    func dynamicLink(fromCustomSchemeURL url: URL) -> DynamicLink? {
        return DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
    }

    func handleDeepLink(_ link: URL) -> Bool {
        return deepLinkManagerProtocol.handleDynamicLink(link)
    }

    func handleUniversalLink(_ url: URL) -> Bool {
        return deepLinkManagerProtocol.handleDynamicLink(url)
    }
}
