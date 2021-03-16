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

        switch toastCase {
        case .emailNotVerified:
            self.setFillColor(color: .black)
            self.cornerRadius = 12

        case .noInternetConnection:
            self.setFillColor(color: R.color.vonoYellow()!)
            self.shadowOpacity = 0
            self.toastTextLabel.textColor = .white
            self.cornerRadius = 12
            self.toastTextLabel.textAlignment = .left
            self.imageView.isHidden = false

        case .noMicrophone,
             .noSpeech,
             .noCamera,
             .noReminder:
            self.setFillColor(color: .black)
            self.cornerRadius = 12
            self.toastTextLabel.textAlignment = .left
            self.buttonStack.isHidden = false

        default:
            self.setFillColor(color: R.color.vonoBlueDark()!)
            self.cornerRadius = 22
        }
    }
}

extension Toast {
    enum ToastCases: String {
        case sending = "Sending memo..."
        case sent = "Memo sent!"

        case cantSaveNote = "Couldn't save note .."

        case emailNotVerified = "This email has not been verified yet. The recipient will become active after successful verification."
        case noInternetConnection = "No internet connection found, we will try to send a memo again when connected again"

        case resendEmailSuccess = "Email sent"
        case resendEmailFailure = "Couldn't send an email"

        case linkCopied = "Copied"
        case errorLinkCopy = "Couldn't generate a link"

        case reminderSaved = "Reminder added"
        case reminderError = "Couldn't save the reminder"

        case noMicrophone = "Turn on the microphone in your phone settings to use this functionality."
        case noSpeech = "Turn on the speech in your phone settings to use this functionality."
        case noCamera = "Turn on the camera in your phone settings to use this functionality."
        case noReminder = "Turn on the reminders in your phone settings to use this functionality."
    }
}
