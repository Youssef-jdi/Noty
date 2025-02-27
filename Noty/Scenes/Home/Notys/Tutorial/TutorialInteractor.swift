//
//  TutorialInteractor.swift
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

protocol TutorialInteractorProtocol {
    func handleViewDidLoad()
    func handleFinishTutorial()
    func handleNextState()
}

class TutorialInteractor: TutorialInteractorProtocol {

    // MARK: DI
    var presenter: TutorialPresenterProtocol
    var stateManager: TutorialStateManagerProtocol
    var userDefaultManager: UserDefaultsManagerProtocol

    init(
        presenter: TutorialPresenterProtocol,
        stateManager: TutorialStateManagerProtocol,
        userDefaultManager: UserDefaultsManagerProtocol
    ) {
        self.presenter = presenter
        self.stateManager = stateManager
        self.userDefaultManager = userDefaultManager
    }
}

extension TutorialInteractor {
    func handleViewDidLoad() {
        presenter.presentState(stateManager.state)
    }

    func handleFinishTutorial() {
        userDefaultManager.isTutoDisplayed = true
        presenter.presentFinishTutorial()
    }

    func handleNextState() {
        stateManager.state == .left ? handleFinishTutorial() : presenter.presentState(stateManager.nextState())
    }
}
