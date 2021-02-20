//
//  SplashScreenStoryboard.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//
import Swinject
import SwinjectStoryboard

// swiftlint:disable implicit_return
class SplashScreenStoryboard: Storyboard {

    private let container: Container
    private let assembly: Assembly
    private let storyboard: SwinjectStoryboard

    init(sharedContainer: Container, assembly: Assembly) {
        self.assembly = assembly
        container = Container(parent: sharedContainer)
        assembly.assemble(container: container)
        storyboard = SwinjectStoryboard.create(name: R.storyboard.splashScreen.name, bundle: nil, container: container)
    }

    func initial<T>() -> T? where T: UIViewController {
        return storyboard.instantiateInitialViewController() as? T
    }

    func viewController<T>(identifier: StoryboardId) -> T? where T: UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier.identifier) as? T
    }
}

enum SplashScreenStoryboardId: StoryboardId {
    case splashScreen

    var identifier: String {
        switch self {
        case .splashScreen: return R.storyboard.splashScreen.splashScreenViewController.identifier
        }
    }
}
