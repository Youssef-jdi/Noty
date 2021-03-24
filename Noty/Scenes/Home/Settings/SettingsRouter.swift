////
//  SettingsRouter.swift
//  Noty
//
//  Created by Youssef Jdidi on 9/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol SettingsRouterProtocol {
  func set(viewController: SettingsViewControllerProtocol?)
  func route(to scene: SettingsRouter.Scene)
}

class SettingsRouter: NSObject, SettingsRouterProtocol {

    // MARK: DI
    weak var viewController: SettingsViewControllerProtocol?
    private let rootNavigator: RootNavigatorProtocol
    private let homeStoryboard: Storyboard

    func set(viewController: SettingsViewControllerProtocol?) {
        self.viewController = viewController
    }

    init(
        rootNavigator: RootNavigatorProtocol,
        homeStoryboard: Storyboard
    ) {
        self.rootNavigator = rootNavigator
        self.homeStoryboard = homeStoryboard
    }
}

// MARK: Routing logic
extension SettingsRouter {

    enum Scene {
        case destination1
    }

    func route(to scene: SettingsRouter.Scene) {
        switch scene {
        case .destination1: break
        }
    }
}
