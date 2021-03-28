//
//  RGB.swift
//  Noty
//
//  Created by Youssef Jdidi on 28/3/2021.
//

import UIKit

struct RGB {

    var r: CGFloat
    var g: CGFloat
    var b: CGFloat

    static func toHSV(r: CGFloat, g: CGFloat, b: CGFloat) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)

        let v = max
        let delta = max - min

        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) }
        let s = delta / max

        let hue: (CGFloat, CGFloat) -> CGFloat = { max, delta -> CGFloat in
            if r == max { return (g - b) / delta }
            else if g == max { return 2 + (b - r)/delta }
            else { return 4 + (r - g) / delta }
        }

        let h = hue(max, delta) * 60 // In degrees

        return HSV(h: (h < 0 ? h+360 : h) , s: s, v: v)
    }

    var hsv: HSV {
        return RGB.toHSV(r: self.r, g: self.g, b: self.b)
    }
}
