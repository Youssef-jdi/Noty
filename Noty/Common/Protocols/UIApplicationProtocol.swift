//
//  UIApplicationProtocol.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import UIKit

protocol UIApplicationProtocol {
    var keyWindow: UIWindow? { get }
    var rootViewController: UIViewController? { get set }

    func topViewController(controller: UIViewController?) -> UIViewController?
}

extension UIApplication: UIApplicationProtocol {
    var rootViewController: UIViewController? {
        get { return keyWindow?.rootViewController }
        set { keyWindow?.rootViewController = newValue }
    }

    func topViewController(controller: UIViewController?) -> UIViewController? {
        var base: UIViewController?
        if controller == nil {
            base = rootViewController
        } else { base = controller }
        if let navigationController = base as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = base as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(controller: presented)
        }
        return base
    }
}
