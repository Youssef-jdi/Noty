//
//  TitleAlertInteractor.swift
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

protocol TitleAlertInteractorProtocol {
    func saveNote(with text: String, and title: String?)
}

class TitleAlertInteractor: TitleAlertInteractorProtocol {

    // MARK: DI
    var presenter: TitleAlertPresenterProtocol
    var noteService: NoteServiceProtocol
    var dataValidator: DataValidatorProtocol

    init(
        presenter: TitleAlertPresenterProtocol,
        noteService: NoteServiceProtocol,
        dataValidator: DataValidatorProtocol
    ) {
        self.presenter = presenter
        self.noteService = noteService
        self.dataValidator = dataValidator
    }
}

extension TitleAlertInteractor {
    func saveNote(with text: String, and title: String?) {
        do {
            try checkTitle(title: title)
            guard let title = title else { return }
            self.saveNoteToDB(text: text, title: title)
        } catch {
            presenter.presentEmptyTitleError()
        }
    }

    private func saveNoteToDB(text: String, title: String) {
        var model = NoteModel(
            id: nil,
            title: title,
            text: text,
            isFavorite: false,
            isReminded: false,
            remindedDate: nil)
        noteService.save(from: &model) {[weak self] result in
            guard let self = self else { return }
            self.presenter.present(save: result)
        }
    }
}

fileprivate extension TitleAlertInteractor {
    func checkTitle(title: String?) throws {
        guard let title = title else { return }
        try dataValidator.validateTitle(title)
    }
}