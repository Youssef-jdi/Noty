//
//  RoundView.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import UIKit

class RoundView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}
