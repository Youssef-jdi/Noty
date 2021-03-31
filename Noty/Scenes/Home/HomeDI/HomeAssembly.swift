//
//  HomeAssembly.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import Swinject
import SwinjectAutoregistration

class HomeAssembly: Assembly {
    // swiftlint:disable function_body_length
    func assemble(container: Container) {
        // MARK: home vc
        container.register(HomeRouterProtocol.self) { resolver in
            return HomeRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name),
                alertsStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(HomeInteractorProtocol.self, initializer: HomeInteractor.init)
        container.autoregister(HomePresenterProtocol.self, initializer: HomePresenter.init)

        container.storyboardInitCompleted(HomeViewController.self) { resolver, vc in
            let presenter = resolver ~> (HomePresenterProtocol.self)
            let interactor = resolver ~> (HomeInteractorProtocol.self)
            let router = resolver ~> (HomeRouterProtocol.self)
            let alertPresenter = resolver ~> (AlertPresenterProtocol.self)
            let toastManager = resolver ~> (ToastManagerProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
            vc.set(alertPresenter: alertPresenter)
            vc.set(toastManager: toastManager)
        }

        // MARK: Root vc
        container.register(RootRouterProtocol.self) { resolver in
            return RootRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name))
        }

        container.autoregister(RootPresenterProtocol.self, initializer: RootPresenter.init)
        container.autoregister(RootInteractorProtocol.self, initializer: RootInteractor.init)

        container.storyboardInitCompleted(RootViewController.self) { resolver, vc in
            let router = resolver ~> (RootRouterProtocol.self)
            let presenter = resolver ~> (RootPresenterProtocol.self)
            let interactor = resolver ~> (RootInteractorProtocol.self)
            let homeStoryboard = resolver ~> (Storyboard.self, name: R.storyboard.home.name)

            router.set(viewController: vc)
            presenter.set(viewController: vc)
            presenter.set(homeStoryboard: homeStoryboard)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }

        // MARK: Notys vc
        container.register(NotysRouterProtocol.self) { resolver in
            return NotysRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name),
                alertsStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(NotysPresenterProtocol.self, initializer: NotysPresenter.init)
        container.autoregister(NotysInteractorProtocol.self, initializer: NotysInteractor.init)
        container.autoregister(NotysTableViewUtilsProtocol.self, initializer: NotysTableViewUtils.init)

        container.storyboardInitCompleted(NotysViewController.self) { resolver, vc in
            let router = resolver ~> (NotysRouterProtocol.self)
            let presenter = resolver ~> (NotysPresenterProtocol.self)
            let interactor = resolver ~> (NotysInteractorProtocol.self)
            let utils = resolver ~> (NotysTableViewUtilsProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
            vc.set(tableViewUtils: utils)
        }

        // MARK: Tutorial VC
        container.register(TutorialRouterProtocol.self) { resolver in
            return TutorialRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name))
        }

        container.autoregister(TutorialPresenterProtocol.self, initializer: TutorialPresenter.init)
        container.autoregister(TutorialInteractorProtocol.self, initializer: TutorialInteractor.init)
        container.autoregister(TutorialStateManagerProtocol.self, initializer: TutorialStateManager.init)

        container.storyboardInitCompleted(TutorialViewController.self) { resolver, vc in
            let router = resolver ~> (TutorialRouterProtocol.self)
            let interactor = resolver ~> (TutorialInteractorProtocol.self)
            let presenter = resolver ~> (TutorialPresenterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(interactor: interactor)
            vc.set(router: router)
        }

        // MARK: Settings VC
        container.register(SettingsRouterProtocol.self) { resolver in
            return SettingsRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name),
                alertStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(SettingsPresenterProtocol.self, initializer: SettingsPresenter.init)
        container.autoregister(SettingsInteractorProtocol.self, initializer: SettingsInteractor.init)
        container.autoregister(SettingsCollectionViewUtilitiesProtocol.self, initializer: SettingsCollectionViewUtilities.init)

        container.storyboardInitCompleted(SettingsViewController.self) { resolver, vc in
            let router = resolver ~> (SettingsRouterProtocol.self)
            let presenter = resolver ~> (SettingsPresenterProtocol.self)
            let interactor = resolver ~> (SettingsInteractorProtocol.self)
            let utilities = resolver ~> (SettingsCollectionViewUtilitiesProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
            vc.set(utilities: utilities)
        }

        // MARK: Home Navigation Controller
        container.autoregister(HomeNavigationInteractorProtocol.self, initializer: HomeNavigationInteractor.init)
        container.autoregister(HomeNavigationPresenterProtocol.self, initializer: HomeNavigationPresenter.init)
        container.storyboardInitCompleted(HomeNavigationController.self) { resolver, vc in
            let interactor = resolver ~> (HomeNavigationInteractorProtocol.self)
            let presenter = resolver ~> (HomeNavigationPresenterProtocol.self)

            vc.set(interactor: interactor)
            presenter.set(viewController: vc)
        }
    }
}
