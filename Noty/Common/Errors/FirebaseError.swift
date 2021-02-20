//
//  FirebaseError.swift
//  Noty
//
//  Created by Youssef Jdidi on 19/2/2021.
//

import Foundation

enum FirebaseError: AppError {
    case signingIn(Error)
    case errorOccured
    case errorAddingDocument

    var title: String {
        return "Ooops"
    }

    var localizedDescription: String {
        switch self {
        case .signingIn: return "Error Signing in"
        case .errorOccured: return "Something went wrong"
        case .errorAddingDocument: return "Error adding document"
        }
    }
}
