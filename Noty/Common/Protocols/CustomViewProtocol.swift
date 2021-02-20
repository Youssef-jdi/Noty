//
//  CustomViewProtocol.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/2/2021.
//

import Foundation
import UIKit

protocol CustomViewProtocol: class {
    func commonInit()
}

extension CustomViewProtocol where Self: UIView {

    func commonInit() {
        self.backgroundColor = .clear
        let view = self.loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]
        )
    }

    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)

        // swiftlint:disable:this force_cast
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
