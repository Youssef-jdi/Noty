//
//  OptionCell.swift
//  Noty
//
//  Created by Youssef Jdidi on 27/3/2021.
//

import UIKit

class OptionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    @IBOutlet weak var bottomView: UIView!

    func configure(with theme: UIColor) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.optionSwitch.onTintColor = theme
            self.optionSwitch.thumbTintColor = .black
            self.bottomView.backgroundColor = theme
        }
    }
}
