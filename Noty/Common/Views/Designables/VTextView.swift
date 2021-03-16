//
//  VTextView.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import UIKit

@IBDesignable
class VTextView: UITextView {

    @IBInspectable var placeholderText: String = "Placeholder" {
        didSet {
            self.setPlaceholder()
            self.delegate = self
        }
    }

    var textIsEmpty: ((Bool) -> Void)?
    var textDidChange: (() -> Void)?
    var startEditing: (() -> Void)?
    var endEditing: (() -> Void)?
    var isEmpty: Bool = true

    func setPlaceholder() {
        self.text = placeholderText
        self.textColor = .lightGray
    }
}

extension VTextView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        startEditing?()
        return true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        endEditing?()
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        isEmpty = textView.text == placeholderText || textView.text.isEmpty || textView.textColor == .lightGray
        textIsEmpty?(textView.textColor == .lightGray || textView.text.isEmpty)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
        isEmpty = textView.text == placeholderText || textView.text.isEmpty || textView.textColor == .lightGray
        textIsEmpty?(textView.textColor == .lightGray || textView.text.isEmpty)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        isEmpty = textView.text == placeholderText || textView.text.isEmpty || textView.textColor == .lightGray
        textIsEmpty?(textView.textColor == .lightGray || textView.text.isEmpty)
        textDidChange?()
    }
}
