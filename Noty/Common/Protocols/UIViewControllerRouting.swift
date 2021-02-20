//
//  UIViewControllerRouting.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import UIKit

protocol UIViewControllerRouting {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func show(_ vc: UIViewController, sender: Any?)
    func pop(animated: Bool)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

protocol UINavigationControllerRouting {
    func popViewController(animated: Bool) -> UIViewController?
    func show(_ vc: UIViewController, sender: Any?)
}

extension UIViewController: UIViewControllerRouting {
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
