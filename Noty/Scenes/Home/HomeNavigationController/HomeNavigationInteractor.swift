//
//  HomeNavigationControllerInteractor.swift
//  Noty
//
//  Created by Youssef Jdidi on 31/3/2021.
//

import Foundation

protocol HomeNavigationInteractorProtocol {
    func handleViewDidLoad()
}

class HomeNavigationInteractor: HomeNavigationInteractorProtocol {

    var userDefaults: UserDefaultsManagerProtocol
    var presenter: HomeNavigationPresenterProtocol

    init(
        presenter: HomeNavigationPresenterProtocol,
        userDefaults: UserDefaultsManagerProtocol
    ) {
        self.userDefaults = userDefaults
        self.presenter = presenter
    }
}

extension HomeNavigationInteractor {
    func handleViewDidLoad() {
        presenter.present(color: userDefaults.themeColor)
    }
}
