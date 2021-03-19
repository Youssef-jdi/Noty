//
//  NoteModel.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/3/2021.
//

import Foundation

struct NoteModel {
    /**
     - Id is a var cause it's assigned when we fetch the count of our Entity in DB
     */
    var id: String?
    let text: String
    var isFavorite: Bool
    var isReminded: Bool
    var remindedDate: Int64?

    static func map(from entity: Note) -> NoteModel {
        return NoteModel(id: entity.id,
                         text: entity.text ?? "",
                         isFavorite: entity.isFavourite,
                         isReminded: entity.isReminded,
                         remindedDate: entity.remindedDate)
    }
}

extension NoteModel: Equatable {
    static func == (lhs: NoteModel, rhs: NoteModel) -> Bool {
        return lhs.id == rhs.id
    }
}
