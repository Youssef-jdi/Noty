//
//  HomeAssembly.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import Swinject
import SwinjectAutoregistration

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: home vc
        container.register(HomeRouterProtocol.self) { resolver in
            return HomeRouter(
                rootNavigator: resolver ~> (RootNavigatorProtocol.self),
                homeStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.home.name))
        }

        container.autoregister(HomeInteractorProtocol.self, initializer: HomeInteractor.init)
        container.autoregister(HomePresenterProtocol.self, initializer: HomePresenter.init)

        container.storyboardInitCompleted(HomeViewController.self) { resolver, vc in
            let presenter = resolver ~> (HomePresenterProtocol.self)
            let interactor = resolver ~> (HomeInteractorProtocol.self)
            let router = resolver ~> (HomeRouterProtocol.self)
            let alertPresenter = resolver ~> (AlertPresenterProtocol.self)

            router.set(viewController: vc)
            presenter.set(viewController: vc)

            vc.set(router: router)
            vc.set(interactor: interactor)
            vc.set(alertPresenter: alertPresenter)
        }
    }
}
