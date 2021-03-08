//
//  RootTabView.swift
//  Noty
//
//  Created by Youssef Jdidi on 8/3/2021.
//

import UIKit

class RootTabView: UIView, CustomViewProtocol {

    enum State: Equatable {
        case new
        case notys
        mutating func toggle() {
            self = self == .new ? .notys : .new
        }
    }

    @IBOutlet weak var bottomBorderView: UIView! {
        didSet {
            bottomBorderView.layer.applyShadow(offset: .init(width: 0, height: 5), radius: 10, opacity: 0.15, color: .black)
        }
    }
    @IBOutlet weak var toggleView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func toggle(state: State) {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 5,
                animations: {
                    self.setupToggle(state: state)
            })
    }

    private func setupToggle(state: State) {
        bottomBorderView.transform = state == .new ? .identity : CGAffineTransform(translationX: self.frame.width / 2, y: 0)
    }
}
