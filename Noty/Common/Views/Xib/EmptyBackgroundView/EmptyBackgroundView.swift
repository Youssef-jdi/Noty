//
//  EmptyBackgroundView.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/3/2021.
//

import UIKit

protocol EmptyBackgroundViewDelegate: class {
    func tapNewNote()
}

class EmptyBackgroundView: UIView, CustomViewProtocol {

    weak var delegate: EmptyBackgroundViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @IBAction func setNewNoteClicked(_ sender: Any) {
        delegate?.tapNewNote()
    }
}
