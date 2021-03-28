//
//  HSB.swift
//  Noty
//
//  Created by Youssef Jdidi on 28/3/2021.
//

import UIKit

struct HSV {
    var h: CGFloat // Angle in degrees [0,360] or -1 as Undefined
    var s: CGFloat // Percent [0,1]
    var v: CGFloat // Percent [0,1]

    static func toRGB(h: CGFloat, s: CGFloat, v: CGFloat) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) } // Achromatic grey

        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60 // Sector
        let i = floor(sector)
        let f = sector - i // Factorial part of h

        let p = v * (1 - s)
        let q = v * (1 - (s * f))
        let t = v * (1 - (s * (1 - f)))

        switch i {
        case 0:
            return RGB(r: v, g: t, b: p)
        case 1:
            return RGB(r: q, g: v, b: p)
        case 2:
            return RGB(r: p, g: v, b: t)
        case 3:
            return RGB(r: p, g: q, b: v)
        case 4:
            return RGB(r: t, g: p, b: v)
        default:
            return RGB(r: v, g: p, b: q)
        }
    }

    var rgb: RGB {
        return HSV.toRGB(h: self.h, s: self.s, v: self.v)
    }
}
