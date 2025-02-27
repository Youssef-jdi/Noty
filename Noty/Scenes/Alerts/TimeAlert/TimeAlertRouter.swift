////
//  TimeAlertRouter.swift
//  Noty
//
//  Created by Youssef Jdidi on 20/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol TimeAlertRouterProtocol {
  func set(viewController: TimeAlertViewControllerProtocol?)
  func route(to scene: TimeAlertRouter.Scene)
}

class TimeAlertRouter: NSObject, TimeAlertRouterProtocol {

    //MARK: DI
    weak var viewController: TimeAlertViewControllerProtocol?
    private let rootNavigator: RootNavigatorProtocol
    private let alertsStoryboard: Storyboard

    func set(viewController: TimeAlertViewControllerProtocol?) {
        self.viewController = viewController
    }

    init(
        rootNavigator: RootNavigatorProtocol,
        alertsStoryboard: Storyboard
    ) {
        self.rootNavigator = rootNavigator
        self.alertsStoryboard = alertsStoryboard
    }
}

// MARK: Routing logic
extension TimeAlertRouter {

    enum Scene {
        case destination1
    }

    func route(to scene: TimeAlertRouter.Scene) {
        switch scene {
        case .destination1:
            /// TODO: Implement routing
            break
        }
    }
}

