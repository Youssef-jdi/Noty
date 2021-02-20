//
//  TopViewController.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import UIKit

protocol TopViewControllerProviderProtocol {
    func topViewController() -> UIViewControllerRouting?
}

class TopViewControllerProvider: TopViewControllerProviderProtocol {

    private let application: UIApplicationProtocol

    init(application: UIApplicationProtocol) {
        self.application = application
    }

    func topViewController() -> UIViewControllerRouting? {
        return application.topViewController(controller: nil)
    }
}
