//
//  DataValidationError.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//

import Foundation

enum DataValidationError: AppError, Equatable {
    case invalidEmail
    case emailDontMatch
    case emptyTitle

    var title: String {
        return "Ooops"
    }

    var localizedDescription: String {
        switch self {
        case .invalidEmail: return "This email is invalid. Please try again. 😣"
        case .emailDontMatch: return "Email and Confirm Email don't match. 😣"
        case .emptyTitle: return "Title can't be empty 😣"
        }
    }
}
