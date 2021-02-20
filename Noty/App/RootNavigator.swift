//
//  RootNavigator.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Foundation

protocol RootNavigatorProtocol {
    func setRootViewController()
}

class RootNavigator: RootNavigatorProtocol {

    private var application: UIApplicationProtocol
    private let onBoardingStoryboard: Storyboard
    private let splashScreenStoryboard: Storyboard

    init(
        application: UIApplicationProtocol,
        onBoardingStoryboard: Storyboard,
        splashScreenStoryboard: Storyboard
    ) {
        self.application = application
        self.onBoardingStoryboard = onBoardingStoryboard
        self.splashScreenStoryboard = splashScreenStoryboard
    }

    func setRootViewController() {
        application.rootViewController = splashScreenStoryboard.initial()
    }
}
