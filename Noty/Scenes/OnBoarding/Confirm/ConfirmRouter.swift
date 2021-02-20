////
//  ConfirmRouter.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol ConfirmRouterProtocol {
  func set(viewController: ConfirmViewControllerProtocol?)
  func route(to scene: ConfirmRouter.Scene)
}

class ConfirmRouter: NSObject, ConfirmRouterProtocol {

    // MARK: DI
    weak var viewController: ConfirmViewControllerProtocol?
    private let rootNavigator: RootNavigatorProtocol
    private let onboardingStoryboard: Storyboard

    func set(viewController: ConfirmViewControllerProtocol?) {
        self.viewController = viewController
    }

    init(
        rootNavigator: RootNavigatorProtocol,
        onboardingStoryboard: Storyboard
    ) {
        self.rootNavigator = rootNavigator
        self.onboardingStoryboard = onboardingStoryboard
    }
}

// MARK: Routing logic
extension ConfirmRouter {

    enum Scene {
        case login
    }

    func route(to scene: ConfirmRouter.Scene) {
        switch scene {
        case .login: viewController?.pop(animated: true)
        }
    }
}
