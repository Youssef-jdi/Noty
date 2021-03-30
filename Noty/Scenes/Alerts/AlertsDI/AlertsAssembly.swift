//
//  AlertsAssembly.swift
//  Noty
//
//  Created by Youssef Jdidi on 20/3/2021.
//

import Swinject
import SwinjectAutoregistration

class AlertsAssemly: Assembly {
    // swiftlint:disbale function_body_length
    func assemble(container: Container) {
        // MARK: Date Alert vc
        container.register(DateAlertRouterProtocol.self) { resolver in
            return DateAlertRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                alertsStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(DateAlertPresenterProtocol.self, initializer: DateAlertPresenter.init)
        container.autoregister(DateAlertInteractorProtocol.self, initializer: DateAlertInteractor.init)
        container.autoregister(AlertsTransition.self, initializer: AlertsTransition.init)

        container.storyboardInitCompleted(DateAlertViewController.self) { resolver, vc in
            let router = resolver ~> (DateAlertRouterProtocol.self)
            let presenter = resolver ~> (DateAlertPresenterProtocol.self)
            let interactor = resolver ~> (DateAlertInteractorProtocol.self)
            let transition = resolver ~> (AlertsTransition.self)

            router.set(viewController: vc)
            router.set(transition: transition)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }

        // MARK: Time Alert vc
        container.register(TimeAlertRouterProtocol.self) { resolver  in
            return TimeAlertRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                alertsStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(TimeAlertPresenterProtocol.self, initializer: TimeAlertPresenter.init)
        container.autoregister(TimeAlertInteractorProtocol.self, initializer: TimeAlertInteractor.init)

        container.storyboardInitCompleted(TimeAlertViewController.self) { resolver, vc in
            let router = resolver ~> (TimeAlertRouterProtocol.self)
            let presenter = resolver ~> (TimeAlertPresenterProtocol.self)
            let interactor = resolver ~> (TimeAlertInteractorProtocol.self)
            let alertPresenter = resolver ~> (AlertPresenterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
            vc.set(alertPresenter: alertPresenter)
        }

        // MARK: Language Alert vc
        container.register(LanguageAlertRouterProtocol.self) { resolver in
            return LanguageAlertRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                alertsStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(LanguageAlertPresenterProtocol.self, initializer: LanguageAlertPresenter.init)
        container.autoregister(LanguageAlertInteractorProtocol.self, initializer: LanguageAlertInteractor.init)

        container.storyboardInitCompleted(LanguageAlertViewController.self) { resolver, vc in
            let router = resolver ~> (LanguageAlertRouterProtocol.self)
            let interactor = resolver ~> (LanguageAlertInteractorProtocol.self)
            let presenter = resolver ~> (LanguageAlertPresenterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }

        // MARK: Title Alert vc
        container.register(TitleAlertRouterProtocol.self) { resolver in
            return TitleAlertRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                alertsStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.alerts.name))
        }

        container.autoregister(TitleAlertPresenterProtocol.self, initializer: TitleAlertPresenter.init)
        container.autoregister(TitleAlertInteractorProtocol.self, initializer: TitleAlertInteractor.init)

        container.storyboardInitCompleted(TitleAlertViewController.self) { resolver, vc in
            let router = resolver ~> (TitleAlertRouterProtocol.self)
            let presenter = resolver ~> (TitleAlertPresenterProtocol.self)
            let interactor = resolver ~> (TitleAlertInteractorProtocol.self)
            let toastManager = resolver ~> (ToastManagerProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(interactor: interactor)
            vc.set(router: router)
            vc.set(toastManager: toastManager)
        }

        // MARK: Theme Alert VC
        container.storyboardInitCompleted(ThemeAlertViewController.self) { resolver, vc in
            let userDefaults = resolver ~> (UserDefaultsManagerProtocol.self)

            vc.set(userDefaults: userDefaults)
        }
    }
}
