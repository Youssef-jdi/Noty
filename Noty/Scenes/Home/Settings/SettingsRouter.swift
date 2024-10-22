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
    private let alertStoryboard: Storyboard

    func set(viewController: SettingsViewControllerProtocol?) {
        self.viewController = viewController
    }

    init(
        rootNavigator: RootNavigatorProtocol,
        homeStoryboard: Storyboard,
        alertStoryboard: Storyboard
    ) {
        self.rootNavigator = rootNavigator
        self.homeStoryboard = homeStoryboard
        self.alertStoryboard = alertStoryboard
    }
}

// MARK: Routing logic
extension SettingsRouter {

    enum Scene {
        case languageAlert(NewLanguageSelectedDelegate?)
        case theme
    }

    func route(to scene: SettingsRouter.Scene) {
        switch scene {
        case .languageAlert(let delegate):
            guard let vc = alertStoryboard.viewController(identifier: AlertsStoryboardId.language) as? LanguageAlertViewController else { assertionFailure(); return }
            vc.delegate = delegate
            viewController?.present(vc, animated: true, completion: nil)
        case .theme:
            guard let vc = alertStoryboard.viewController(identifier: AlertsStoryboardId.theme) as? ThemeAlertViewController else { assertionFailure(); return }
            viewController?.present(vc, animated: true, completion: nil)
        }
    }
}
