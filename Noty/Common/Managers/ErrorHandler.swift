//
//  ErrorHandler.swift
//  Noty
//
//  Created by Youssef Jdidi on 19/2/2021.
//

import UIKit

protocol ErrorHandlerProtocol {
    func handle(_ error: Error)
}

class ErrorHandler: ErrorHandlerProtocol {
    private let alertPresenter: AlertPresenterProtocol

    init(alertPresenter: AlertPresenterProtocol) {
        self.alertPresenter = alertPresenter
    }

    func handle(_ error: Error) {
        guard let appError = error as? AppError else {
            print(error.localizedDescription)
            return
        }
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertPresenter.presentAlert(title: appError.title, description: appError.localizedDescription, actions: [okAction])
    }
}
