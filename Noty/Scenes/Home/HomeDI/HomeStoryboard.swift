//
//  HomeStoryboard.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import Swinject
import SwinjectStoryboard

class HomeStoryboard: Storyboard {
    private let container: Container
    private let assembly: Assembly
    private let storyboard: SwinjectStoryboard

    init(sharedContainer: Container, assembly: Assembly) {
        self.assembly = assembly
        container = Container(parent: sharedContainer)
        assembly.assemble(container: container)
        storyboard = SwinjectStoryboard.create(name: R.storyboard.home.name, bundle: nil, container: container)
    }

    func initial<T>() -> T? where T: UIViewController {
        return storyboard.instantiateInitialViewController() as? T
    }

    func viewController<T>(identifier: StoryboardId) -> T? where T: UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier.identifier) as? T
    }
}

enum HomeStoryboardId: StoryboardId {
    case new
    case notys
    case settings
    case tuto

    var identifier: String {
        switch self {
        case .new: return R.storyboard.home.homeViewController.identifier
        case .notys: return R.storyboard.home.notysViewController.identifier
        case .settings: return R.storyboard.home.settingsViewController.identifier
        case .tuto: return R.storyboard.home.tutorialViewController.identifier
        }
    }
}
