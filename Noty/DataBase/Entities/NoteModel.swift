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
    let isFavorite: Bool
    let isReminded: Bool
    let remindedDate: Int64?

    static func map(from entity: Note) -> NoteModel {
        return NoteModel(id: entity.id,
                         text: entity.text ?? "",
                         isFavorite: entity.isFavourite,
                         isReminded: entity.isReminded,
                         remindedDate: entity.remindedDate)
    }
}
