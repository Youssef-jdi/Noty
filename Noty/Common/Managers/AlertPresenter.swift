//
//  AlertPresenter.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import UIKit

protocol AlertPresenterProtocol {
    func presentAlert(title: String?, description: String?, actions: [UIAlertAction])
    func presentActionSheet(title: String?, description: String?, actions: [UIAlertAction])
    func presentAlertAttributed(title: NSAttributedString, description: NSAttributedString, actions: [UIAlertAction])
    func presentPermissionAlert(with messageError: HomeModels.PermissionError)
}

class AlertPresenter: AlertPresenterProtocol {
    private let topViewControllerProvider: TopViewControllerProviderProtocol

    init(topViewControllerProvider: TopViewControllerProviderProtocol) {
        self.topViewControllerProvider = topViewControllerProvider
    }

    func presentActionSheet(title: String?, description: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
    }

    func presentAlert(title: String?, description: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            actions.forEach { alert.addAction($0) }
            self.topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }

    func presentAlertAttributed(
        title: NSAttributedString,
        description: NSAttributedString,
        actions: [UIAlertAction]
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alert.setValue(title, forKey: "attributedTitle")
            alert.setValue(description, forKey: "attributedMessage")
            actions.forEach { alert.addAction($0) }
            self.topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }

    func presentPermissionAlert(with messageError: HomeModels.PermissionError) {

        var message = ""

        switch messageError {
        case .audio:
            message = "You have denied access for Noty to access your Microphone.\n\nPlease go to the Settings app and enable Microphone access in order to record audio."
        case .speech:
            message = "You have denied access for Noty to access your Speech.\n\nPlease go to the Settings app and enable Camera access in order to send images."
        case .notif:
            message = "You have denied access for Noty to send notification.\n\nPlease go to the Settings app and enable access in order to get notifications"
        }

        let alert = UIAlertController(
            title: "Privacy Settings",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let openSettingsURLString = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(openSettingsURLString, options: [:], completionHandler: nil)
        }
        alert.addAction(okAction)
        alert.addAction(settingsAction)

        self.topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
