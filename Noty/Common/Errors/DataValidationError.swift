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

    var title: String {
        switch self {
        case .invalidEmail: return "Ooops"
        case .emailDontMatch: return "Ooops"
        }
    }

    var localizedDescription: String {
        switch self {
        case .invalidEmail: return "This email is invalid. Please try again."
        case .emailDontMatch: return "Email and Confirm Email don't match."
        }
    }
}
