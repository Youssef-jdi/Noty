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
    func save(from note: inout NoteModel, _ completion: @escaping RequestLocalCompletion<Note>)
    func deleteAllNotes()
    func deleteNote(_ note: NoteModel)
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

    func save(from note: inout NoteModel, _ completion: @escaping RequestLocalCompletion<Note>) {
        let context = coreDataController.backgroundContext
        let count = coreDataController.getCount(entityName: Note.entityName)
        note.id = "\(count + 1)"
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

    func deleteAllNotes() {
        coreDataController.delete(entityName: Note.entityName, predicate: nil)
    }

    func deleteNote(_ note: NoteModel) {
        guard let id = note.id else { return }
        let predicate = NSPredicate(format: "id == %@", id as NSString)
        coreDataController.delete(entityName: Note.entityName, predicate: predicate)
    }

    func updateNote() {}
}
