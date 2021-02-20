//
//  SplashScreenAssembly.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Swinject
import SwinjectAutoregistration

class SplashScreenAsembly: Assembly {
    /// still missing home storyboard
    func assemble(container: Container) {
        // MARK: SplashScreen DI
        container.register(SplashScreenRouterProtocol.self) { resolver in
            return SplashScreenRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                onBoardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name)
                )
        }

        container.autoregister(SplashScreenInteractorProtocol.self, initializer: SplashScreenInteractor.init)
        container.autoregister(SplashScreenPresenterProtocol.self, initializer: SplashScreenPresenter.init)

        container.storyboardInitCompleted(SplashScreenViewController.self) { resolver, vc in
            let presenter = resolver ~> (SplashScreenPresenterProtocol.self)
            let interactor = resolver ~> (SplashScreenInteractorProtocol.self)
            let router = resolver ~> (SplashScreenRouterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
        }
    }
}
