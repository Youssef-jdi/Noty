//
//  SwiftUI + Utils.swift
//  Noty
//
//  Created by Youssef Jdidi on 28/3/2021.
//

import SwiftUI

func atan2To360(_ angle: CGFloat) -> CGFloat {
    var result = angle
    if result < 0 {
        result = (2 * CGFloat.pi) + angle
    }
    return result * 180 / CGFloat.pi
}

func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    let xDist = a.x - b.x
    let yDist = a.y - b.y
    return CGFloat(sqrt(xDist * xDist + yDist * yDist))
}

extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
}
