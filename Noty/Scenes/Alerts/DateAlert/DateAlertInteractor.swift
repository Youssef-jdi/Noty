//
//  DateAlertInteractor.swift
//  Noty
//
//  Created by Youssef Jdidi on 20/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol DateAlertInteractorProtocol {
    func handleViewDidLoad()
    func convertDate(date: Date)
}

class DateAlertInteractor: DateAlertInteractorProtocol {

    // MARK: DI
    var presenter: DateAlertPresenterProtocol
    var dateFormatter: DateFormatterProtocol

    init(
        presenter: DateAlertPresenterProtocol,
        dateFormatter: DateFormatterProtocol
        ) {
        self.presenter = presenter
        self.dateFormatter = dateFormatter
    }
}

extension DateAlertInteractor {

    func handleViewDidLoad() {
        presenter.present(
            date: dateFormatter.currentDate(),
            year: dateFormatter.get(date: Date(), in: "yyyy"),
            dateText: dateFormatter.get(date: Date(), in: "E, MMM d"))
    }

    func convertDate(date: Date) {
        presenter.present(
            date: dateFormatter.get(date: date, in: "E, MMM d"),
            year: dateFormatter.get(date: date, in: "yyyy"))
    }
}
