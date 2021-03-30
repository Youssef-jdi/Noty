//
//  ColorWheel.swift
//  Noty
//
//  Created by Youssef Jdidi on 28/3/2021.
//

import SwiftUI

struct ColorWheel: View {
    var radius: CGFloat
    @Binding var rgbColour: RGB
    @Binding var brightness: CGFloat

    var body: some View {

        DispatchQueue.main.async {
            self.rgbColour = HSV(h: self.rgbColour.hsv.h, s: self.rgbColour.hsv.s, v: self.brightness).rgb
        }

        return GeometryReader { geometry in
            ZStack {
                CIHueSaturationValueGradientView(radius: self.radius, brightness: self.$brightness)
                    .blur(radius: 10)
                    .overlay(
                        Circle()
                            .size(CGSize(width: self.radius, height: self.radius))
                            .stroke(Color(R.color.outline.name), lineWidth: 10)
                            .shadow(color: Color(R.color.shadowInner.name), radius: 8)
                    )
                    .clipShape(
                        Circle()
                            .size(CGSize(width: self.radius, height: self.radius))
                    )
                    .shadow(color: Color(R.color.shadowOuter.name), radius: 15)

                RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.8 * Double(self.brightness)), .clear]), center: .center, startRadius: 0, endRadius: self.radius / 2 - 10)
                    .blendMode(.screen)

                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: 15, height: 15, alignment: .center)
                    .offset(x: (self.radius / 2 - 10) * self.rgbColour.hsv.s)
                    .rotationEffect(.degrees(-Double(self.rgbColour.hsv.h)))
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5).stroke(Color.white, lineWidth: 2.0)
                    )
            }

            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in

                        let y = geometry.frame(in: .global).midY - value.location.y
                        let x = value.location.x - geometry.frame(in: .global).midX

                        let hue = atan2To360(atan2(y, x))
                        let center = CGPoint(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY)

                        let saturation = min(distance(center, value.location) / (self.radius / 2), 1)

                        self.rgbColour = HSV(h: hue, s: saturation, v: self.brightness).rgb
                        self.shareThemeColor()
                    }
            )
        }
        .frame(width: self.radius, height: self.radius)
    }

    private func shareThemeColor() {
        let userInfo: [AnyHashable: Any] = ["rgb": self.rgbColour]
        NotificationCenter.default.post(name: newColor, object: nil, userInfo: userInfo)
    }
}
