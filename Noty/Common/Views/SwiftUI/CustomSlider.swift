//
//  CustomSlider.swift
//  Noty
//
//  Created by Youssef Jdidi on 28/3/2021.
//

import SwiftUI

struct CustomSlider: View {

    @Binding var rgbColour: RGB
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat>
    @State var lastOffset: CGFloat = 0
    @State var isTouchingKnob = false
    var leadingOffset: CGFloat = 8
    var trailingOffset: CGFloat = 8
    var knobSize = CGSize(width: 28, height: 28)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 30)

                    .foregroundColor(Color(red: Double(self.rgbColour.r), green: Double(self.rgbColour.g), blue: Double(self.rgbColour.b)))

                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(R.color.outline.name), lineWidth: 3)
                    )
                    .shadow(color: Color(R.color.shadowOuter.name), radius: 18)
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(R.color.outline.name), lineWidth: self.isTouchingKnob ? 4 : 5)
                            .frame(width: self.knobSize.width, height: self.knobSize.height)

                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color(red: Double(self.rgbColour.r - 0.1), green: Double(self.rgbColour.g - 0.1), blue: Double(self.rgbColour.b - 0.1)))
                            .frame(width: self.knobSize.width, height: self.knobSize.height)
                    }
                    .offset(x: self.$value.wrappedValue.map(from: self.range, to: self.leadingOffset...(geometry.size.width - self.knobSize.width - self.trailingOffset)))
                    .shadow(color: Color(R.color.shadowOuter.name), radius: 18)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in

                                self.isTouchingKnob = true
                                if abs(value.translation.width) < 0.1 {
                                    self.lastOffset = self.$value.wrappedValue.map(from: self.range, to: self.leadingOffset...(geometry.size.width - self.knobSize.width - self.trailingOffset))
                                }

                                let sliderPos = max(0 + self.leadingOffset, min(self.lastOffset + value.translation.width, geometry.size.width - self.knobSize.width - self.trailingOffset))
                                let sliderVal = sliderPos.map(from: self.leadingOffset...(geometry.size.width - self.knobSize.width - self.trailingOffset), to: self.range)

                                self.value = sliderVal
                            }
                            .onEnded { _ in
                                self.isTouchingKnob = false
                                self.shareThemeColor()
                            }
                        )
                    Spacer()
                }
            }
        }
        .frame(height: 40)
    }

    private func shareThemeColor() {
        let userInfo: [AnyHashable: Any] = ["rgb": self.rgbColour]
        NotificationCenter.default.post(name: newColor, object: nil, userInfo: userInfo)
    }
}
