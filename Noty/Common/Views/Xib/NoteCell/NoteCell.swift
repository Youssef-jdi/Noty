//
//  NoteCell.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/3/2021.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func configure(with text: String) {
        titleLabel.text = text
    }
}
