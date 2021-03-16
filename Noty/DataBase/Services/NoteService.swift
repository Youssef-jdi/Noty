//
//  NoteService.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/3/2021.
//

import Foundation
import CoreData

protocol NoteServiceProtocol {
    func fetchNotes(_ completion: @escaping ArrayLocalCompletion<Note>)
    func save(from note: NoteModel, _ completion: @escaping RequestLocalCompletion<Note>)
    func deleteNote()
    func updateNote()
}

class NoteDataService: NoteServiceProtocol {

    private var coreDataController: CoreDataControllerProtocol

    init(coreDataController: CoreDataControllerProtocol) {
        self.coreDataController = coreDataController
    }

    func fetchNotes(_ completion: @escaping ArrayLocalCompletion<Note>) {
        let context = coreDataController.backgroundContext
        coreDataController.fetch(entityName: Note.entityName, predicate: nil, context: context) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func save(from note: NoteModel, _ completion: @escaping RequestLocalCompletion<Note>) {
        let context = coreDataController.backgroundContext

        context.performAndWait {
            let noteEntity = Note.createNote(from: note, for: context)

            coreDataController.saveIfNeeded(context) { result in
                switch result {
                case .success:
                    completion(.success(noteEntity))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func deleteNote() {
        let name = Note.entityName
        coreDataController.delete(entityName: name, predicate: nil)
    }

    func updateNote() {}
}
