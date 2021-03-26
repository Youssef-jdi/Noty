//
//  Toast.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/2/2021.
//

import UIKit

class Toast: RoundedView, CustomViewProtocol {

    // MARK: - IBOutlets

    @IBOutlet var contentView: RoundedView!
    @IBOutlet weak var toastTextLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func configureToast(with toastCase: ToastCases) {
        self.toastTextLabel.text = toastCase.rawValue
        self.setFillColor(color: R.color.vonoBlueDark()!)
        self.cornerRadius = 22
    }
}

extension Toast {
    enum ToastCases: String {

        case cantSaveNote = "Couldn't save note .."
        case noteSaved = "Note saved 👀"

        case emptyTitle = "Title can't be empty 🥲"

        case resendEmailSuccess = "Email sent"
        case resendEmailFailure = "Couldn't send an email"
    }
}
