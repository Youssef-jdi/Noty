//
//  NoteModel.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/3/2021.
//

import Foundation

struct NoteModel {
    let id: String?
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
