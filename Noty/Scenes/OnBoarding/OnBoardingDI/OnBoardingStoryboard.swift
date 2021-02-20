//
//  OnBoardingStoryboard.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Swinject
import SwinjectStoryboard

class OnBoardingStoryboard: Storyboard {
    private let container: Container
    private let assembly: Assembly
    private let storyboard: SwinjectStoryboard

    init(sharedContainer: Container, assembly: Assembly) {
        self.assembly = assembly
        container = Container(parent: sharedContainer)
        assembly.assemble(container: container)
        storyboard = SwinjectStoryboard.create(name: R.storyboard.onBoarding.name, bundle: nil, container: container)
    }

    func initial<T>() -> T? where T: UIViewController {
        return storyboard.instantiateInitialViewController() as? T
    }

    func viewController<T>(identifier: StoryboardId) -> T? where T: UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier.identifier) as? T
    }
}

enum OnBoardingStoryboardId: StoryboardId {
    case welcome
    case permission
    case language
    case login
    case confirm

    var identifier: String {
        switch self {
        case .welcome: return R.storyboard.onBoarding.welcomeViewController.identifier
        case .permission: return R.storyboard.onBoarding.permissionViewController.identifier
        case .language: return R.storyboard.onBoarding.languageViewController.identifier
        case .login: return R.storyboard.onBoarding.loginViewController.identifier
        case .confirm: return R.storyboard.onBoarding.confirmViewController.identifier
        }
    }
}
