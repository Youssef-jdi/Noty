//
//  ConfigCell.swift
//  Noty
//
//  Created by Youssef Jdidi on 24/3/2021.
//

import UIKit
import FlagKit

class ConfigCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!

    func configureCell(with config: Config) {
        titleLabel.text = config.mainText
        if let secondary = config.secondaryText, let locale = config.flagImage, let region = locale.regionCode, let flag = Flag(countryCode: region) {
            languageLabel.isHidden = false
            flagImageView.isHidden = false
            languageLabel.text = secondary
            flagImageView.image = flag.image(style: .roundedRect)
        } else {
            languageLabel.isHidden = true
            flagImageView.isHidden = true
        }
    }
}
