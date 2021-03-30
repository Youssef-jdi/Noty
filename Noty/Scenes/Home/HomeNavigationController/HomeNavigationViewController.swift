//
//  HomeNavigationViewController.swift
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

class HomeNavigationController: UINavigationController, WillReceiveNewColor {

    // MARK: DI
    func set(userDefaults: UserDefaultsManagerProtocol) {
        self.userDefaults = userDefaults
    }

    // MARK: Properties
    var userDefaults: UserDefaultsManagerProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeColorChange()
        self.delegate = self
    }

    func setup() {
        navigationBar.barTintColor = userDefaults?.themeColor
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
    }

    func observeColorChange() {
        handleNewColorReceived {[weak self] color in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.navigationBar.barTintColor = color
            }
        }
    }

    // MARK: - Object Lifecycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let backButton = UIButton(type: .close)
        backButton.setImage(R.image.ic_arrow_back_white(), for: .normal)
        let item = UIBarButtonItem(customView: backButton)
        viewController.navigationItem.backBarButtonItem = item
    }
}
