//
//  DeepLinkRouter.swift
//  Noty
//
//  Created by Youssef Jdidi on 19/2/2021.
//

import Foundation

protocol DeepLinkRouterProtocol {
    func route(to scene: DeepLinkRouter.Scene)
}

class DeepLinkRouter: DeepLinkRouterProtocol {

    private let topViewController: TopViewControllerProviderProtocol
    private let onboardingStoryboard: Storyboard

    init(
        topViewController: TopViewControllerProviderProtocol,
        onboardingStoryboard: Storyboard
    ) {
        self.topViewController = topViewController
        self.onboardingStoryboard = onboardingStoryboard
    }

    enum Scene {
        case language
    }

    func route(to scene: DeepLinkRouter.Scene) {
        switch scene {
        case .language:
            guard let languageVC = onboardingStoryboard.viewController(identifier: OnBoardingStoryboardId.language) as? LanguageViewController else { return }
            topViewController.topViewController()?.show(languageVC, sender: nil)
        }
    }
}
