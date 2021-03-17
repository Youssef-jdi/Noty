//
//  UILabel + Utils.swift
//  Noty
//
//  Created by Youssef Jdidi on 17/3/2021.
//

import UIKit

//swiftlint:disable line_length
extension UILabel {

    /// Sets the label text to a specified string, and applies a paragraph style with a specified text alignment, and line spacing derived from a specified text font size.
    /// - Parameter text: Text for the label.
    /// - Parameter fontSize: Size of the text font, usually specified in a related XIB or Storyboard.
    /// - Parameter alignment: Text alignment.
    func configureParagraph(with text: String, fontSize: CGFloat, alignment: NSTextAlignment) {
        let string = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = fontSize * 1.4
        paragraphStyle.alignment = alignment

        string.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: string.length))
        self.attributedText = string
    }
}
