//
//  LanguageAlertInteractor.swift
//  Noty
//
//  Created by Youssef Jdidi on 24/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol LanguageAlertInteractorProtocol {
    // add the functions that are called from the view controller
}

class LanguageAlertInteractor: LanguageAlertInteractorProtocol {

    // MARK: DI
    var presenter: LanguageAlertPresenterProtocol

    init(presenter: LanguageAlertPresenterProtocol) {
        self.presenter = presenter
    }
}