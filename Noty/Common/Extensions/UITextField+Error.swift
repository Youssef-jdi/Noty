//
//  UITextField+Error.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//

import UIKit

extension UITextField {
    func shakeError() {
        UIView.animate(withDuration: 0.15) {
            self.shake()
            self.textColor = R.color.appLightRed()
        }
    }
}
