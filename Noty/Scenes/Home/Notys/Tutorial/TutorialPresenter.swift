//
//  TutorialPresenter.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/3/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
//  This template is meant to work with Swinject.

import UIKit

protocol TutorialPresenterProtocol {
    func set(viewController: TutorialViewControllerProtocol?)

    // add the functions that are called from interactor
    func presentState(_ state: TutorialState)
    func presentFinishTutorial()
}

class TutorialPresenter: TutorialPresenterProtocol {

    // MARK: DI
    weak var viewController: TutorialViewControllerProtocol?

    func set(viewController: TutorialViewControllerProtocol?) {
        self.viewController = viewController
    }
}

// MARK: Methods
extension  TutorialPresenter {

    func presentState(_ state: TutorialState) {
        viewController?.displayState(state)
    }

    func presentFinishTutorial() {
        viewController?.hideTutorial()
    }
}
