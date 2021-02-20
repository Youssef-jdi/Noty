//
//  OnBoardingAssembly.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Swinject
import SwinjectAutoregistration

class OnBoardingAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: - WelcomeViewController
        container.register(WelcomeRouterProtocol.self) { resolver in
            return WelcomeRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name),
                onBoardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name)
                )
        }

        container.autoregister(WelcomeInteractorProtocol.self, initializer: WelcomeInteractor.init)
        container.autoregister(WelcomePresenterProtocol.self, initializer: WelcomePresenter.init)

        container.storyboardInitCompleted(WelcomeViewController.self) { resolver, vc in
            let presenter = resolver ~> (WelcomePresenterProtocol.self)
            let interactor = resolver ~> (WelcomeInteractorProtocol.self)
            let router = resolver ~> (WelcomeRouterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }

        // MARK: - Permission VC
        container.register(PermissionRouterProtocol.self) { resolver in
            return PermissionRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name))
        }

        container.autoregister(PermissionInteractorProtocol.self, initializer: PermissionInteractor.init)
        container.autoregister(PermissionPresenterProtocol.self, initializer: PermissionPresenter.init)

        container.storyboardInitCompleted(PermissionViewController.self) { resolver, vc in
            let presenter = resolver ~> (PermissionPresenterProtocol.self)
            let interactor = resolver ~> (PermissionInteractorProtocol.self)
            let router = resolver ~> (PermissionRouterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }

        // MARK: - Language VC
        container.register(LanguageRouterProtocol.self) { resolver in
            return LanguageRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                onBoardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name))
        }

        container.autoregister(LanguageInteractorProtocol.self, initializer: LanguageInteractor.init)
        container.autoregister(LanguagePresenterProtocol.self, initializer: LanguagePresenter.init)

        container.storyboardInitCompleted(LanguageViewController.self) { resolver, vc in
            let presenter = resolver ~> (LanguagePresenterProtocol.self)
            let interactor = resolver ~> (LanguageInteractorProtocol.self)
            let router = resolver ~> (LanguageRouterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }

        // MARK: - Login VC
        container.register(LoginRouterProtocol.self) { resolver in
            return LoginRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                onboardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name))
        }

        container.autoregister(LoginInteractorProtocol.self, initializer: LoginInteractor.init)
        container.autoregister(LoginPresenterProtocol.self, initializer: LoginPresenter.init)

        container.storyboardInitCompleted(LoginViewController.self) { resolver, vc in
            let presenter = resolver ~> (LoginPresenterProtocol.self)
            let interactor = resolver ~> (LoginInteractorProtocol.self)
            let router = resolver ~> (LoginRouterProtocol.self)
            let toastManager = resolver ~> (ToastManagerProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
            vc.set(toastManager: toastManager)
        }

        // MARK: - Confirm VC
        container.register(ConfirmRouterProtocol.self) { resolver in
            return ConfirmRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                onboardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name))
        }

        container.autoregister(ConfirmInteractorProtocol.self, initializer: ConfirmInteractor.init)
        container.autoregister(ConfirmPresenterProtocol.self, initializer: ConfirmPresenter.init)

        container.storyboardInitCompleted(ConfirmViewController.self) { resolver, vc in
            let presenter = resolver ~> (ConfirmPresenterProtocol.self)
            let interactor = resolver ~> (ConfirmInteractorProtocol.self)
            let router = resolver ~> (ConfirmRouterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }
    }
}
