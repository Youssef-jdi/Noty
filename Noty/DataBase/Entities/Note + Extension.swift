//
//  Note + Extension.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/3/2021.
//

import CoreData
import Foundation

extension Note {
    static let entityName: String = "Note"

    // swiftlint:disable force_cast
    static func createNote(from note: NoteModel, for context: NSManagedObjectContext) -> Note {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let newNote = NSManagedObject(entity: entity, insertInto: context) as! Note
        updateObject(newNote, from: note)
        return newNote
    }

    static func updateObject(_ noteEntity: Note, from noteModel: NoteModel) {
        noteEntity.id = noteModel.id
        noteEntity.text = noteModel.text
        noteEntity.title = noteModel.title
        noteEntity.isFavourite = noteModel.isFavorite
        noteEntity.isReminded = noteModel.isReminded
    }

    static func updateIsFavorite(_ noteEntity: Note, from noteModel: NoteModel) {
        noteEntity.id = noteModel.id
        noteEntity.text = noteModel.text
        noteEntity.title = noteModel.title
        noteEntity.isFavourite = !noteModel.isFavorite
    }

    static func updateRemindedDate(_ noteEntity: Note, from noteModel: NoteModel) {
        noteEntity.id = noteModel.id
        noteEntity.text = noteModel.text
        noteEntity.title = noteModel.title
        noteEntity.isFavourite = noteModel.isFavorite
        noteEntity.isReminded = !noteModel.isReminded
    }
}
