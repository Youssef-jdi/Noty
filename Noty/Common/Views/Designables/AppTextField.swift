//
//  AppTextField.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//

import UIKit

@IBDesignable
class AppTextField: UITextField {

    @IBInspectable var layerBorderWidth: CGFloat = 1 {
        didSet { setup() }
    }

    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet { setup() }
    }

    @IBInspectable var layerBorderColor: UIColor = .black {
        didSet { setup() }
    }

    @IBInspectable var placeHolderColor: UIColor = .black {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        }
    }

    @IBInspectable var oneLineBorder: Bool = false {
        didSet {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
            bottomLine.backgroundColor = UIColor.gray.cgColor
            self.backgroundColor = .white
            self.borderStyle = .none
            self.layer.addSublayer(bottomLine)
        }
    }

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        guard oneLineBorder else {
            self.setup()
            return
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard oneLineBorder else {
            self.setup()
            return
        }
    }

    /// Base setup. Assigning the values from the `IBInspectable`s.
    private func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = layerBorderWidth
        self.layer.borderColor = layerBorderColor.cgColor
        self.layer.masksToBounds = true
        self.tintColor = layerBorderColor
    }
}
