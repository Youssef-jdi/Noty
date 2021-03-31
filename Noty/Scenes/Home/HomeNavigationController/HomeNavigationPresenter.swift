//
//  HomeNavigationPresenter.swift
//  Noty
//
//  Created by Youssef Jdidi on 31/3/2021.
//

import UIKit

protocol HomeNavigationPresenterProtocol {
    func set(viewController: HomeNavigationControllerProtocol)

    func present(color: UIColor)
}

class HomeNavigationPresenter: HomeNavigationPresenterProtocol {
    
    // MARK: DI
    weak var viewController: HomeNavigationControllerProtocol?

    func set(viewController: HomeNavigationControllerProtocol) {
        self.viewController = viewController
    }
}

extension HomeNavigationPresenter {
    func present(color: UIColor) {
        viewController?.display(color: color)
    }
}
