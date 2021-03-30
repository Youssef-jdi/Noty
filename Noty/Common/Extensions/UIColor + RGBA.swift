//
//  UIColor + RGBA.swift
//  Noty
//
//  Created by Youssef Jdidi on 29/3/2021.
//

import UIKit

extension UIColor {
    // swiftlint:disable large_tuple
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
