//
//  UIViewController + WillReceiveNewColor.swift
//  Noty
//
//  Created by Youssef Jdidi on 29/3/2021.
//

import UIKit

protocol WillReceiveNewColor {
//    var didReceiveNewColor: ((UIColor) -> Void)? { get set }

    func handleNewColorReceived(_ completion: @escaping (UIColor) -> Void)
  //  @objc func receiveNewColor(_ notif: NSNotification)
}

extension WillReceiveNewColor where Self: UIViewController {

    func handleNewColorReceived(_ completion: @escaping (UIColor) -> Void) {
        NotificationCenter.default.addObserver(forName: newColor, object: nil, queue: .none) { notification in
            guard let userInfo = notification.userInfo, let rgb = userInfo["rgb"] as? RGB else { assertionFailure(); return }
            let newColor = UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                completion(newColor)
                //self.didReceiveNewColor?(newColor)
            }
        }
    }
}

enum SceneType {
    case settings
    case navigationBar
    case tabBar
}
