//
//  TitleAlertPresenter.swift
//  Noty
//
//  Created by Youssef Jdidi on 25/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol TitleAlertPresenterProtocol {
    func set(viewController: TitleAlertViewControllerProtocol?)

    // add the functions that are called from interactor
    func present(save result: Result<Storable?, Error>)
    func presentEmptyTitleError()
}

class TitleAlertPresenter: TitleAlertPresenterProtocol {

    // MARK: DI
    weak var viewController: TitleAlertViewControllerProtocol?

    func set(viewController: TitleAlertViewControllerProtocol?) {
        self.viewController = viewController
    }
}

// MARK: Methods
extension  TitleAlertPresenter {

    func present(save result: Result<Storable?, Error>) {
        viewController?.displaySaveResult(save: result)
    }

    func presentEmptyTitleError() {
        viewController?.displayEmptyTitleError()
    }
}
