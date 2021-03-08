//
//  CALayer + applyShadow.swift
//  Noty
//
//  Created by Youssef Jdidi on 8/3/2021.
//

import UIKit

extension CALayer {
    /// Applies a shadow to a layer.
    func applyShadow(offset: CGSize, radius: CGFloat, opacity: Float, color: UIColor) {
        masksToBounds = false
        shadowOffset = offset
        shadowRadius = radius
        shadowOpacity = opacity
        shadowColor = color.cgColor
    }
}
