//
//  SettingsViewController.swift
//  Noty
//
//  Created by Youssef Jdidi on 9/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol SettingsViewControllerProtocol: class, UIViewControllerRouting {
    func set(interactor: SettingsInteractorProtocol)
    func set(router: SettingsRouterProtocol)

    // add the functions that are called from the presenter
    func display(error: Error)
}

class SettingsViewController: UIViewController, SettingsViewControllerProtocol {

    // MARK: DI
    var interactor: SettingsInteractorProtocol?
    var router: SettingsRouterProtocol?

    func set(interactor: SettingsInteractorProtocol) {
        self.interactor = interactor
    }

    func set(router: SettingsRouterProtocol) {
        self.router = router
    }
    
    // MARK: Outlets

    // MARK: Properties

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.vonoBlueDark()
    }

    // MARK: Actions

}

// MARK: Methods
extension SettingsViewController {

    func display(error: Error) {}
}