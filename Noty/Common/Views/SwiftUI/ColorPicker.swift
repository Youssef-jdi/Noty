//
//  ColorPicker.swift
//  Noty
//
//  Created by Youssef Jdidi on 27/3/2021.
//

import SwiftUI

struct ColorPicker: View {
    @State var rgbColour: RGB
    @State var brightness: CGFloat = 1

    var body: some View {
        VStack {
            HStack {
                Text("Pick a color 🤪")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                Spacer()
            }
            ColorWheel(radius: 300, rgbColour: $rgbColour, brightness: $brightness)
            .padding()
            CustomSlider(rgbColour: $rgbColour, value: $brightness, range: 0.001...1)
                .padding()
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker(rgbColour: RGB(r: 1, g: 1, b: 1))
    }
}
