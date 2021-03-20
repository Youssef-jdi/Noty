//
//  AlertsStoryboard.swift
//  Noty
//
//  Created by Youssef Jdidi on 20/3/2021.
//

import Swinject
import SwinjectStoryboard

class AlertsStoryboard: Storyboard {
    private let container: Container
    private let assembly: Assembly
    private let storyboard: SwinjectStoryboard

    init(sharedContainer: Container, assembly: Assembly) {
        self.assembly = assembly
        container = Container(parent: sharedContainer)
        assembly.assemble(container: container)
        storyboard = SwinjectStoryboard.create(name: R.storyboard.alerts.name, bundle: nil, container: container)
    }

    func initial<T>() -> T? where T: UIViewController {
        return storyboard.instantiateInitialViewController() as? T
    }

    func viewController<T>(identifier: StoryboardId) -> T? where T: UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier.identifier) as? T
    }
}

enum AlertsStoryboardId: StoryboardId {
    case date
    case time

    var identifier: String {
        switch self {
        case .date: return R.storyboard.alerts.dateAlertViewController.identifier
        case .time: return R.storyboard.alerts.timeAlertViewController.identifier
        }
    }
}
