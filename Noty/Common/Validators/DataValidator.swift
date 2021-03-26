//
//  DataValidator.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//

import Foundation

protocol DataValidatorProtocol {
    func validateEmail(_ value: String?) throws
    func validateEmailMatch(_ email: String?, _ confirmEmail: String?) throws
    func validateTitle(_ title: String) throws
}

class DataValidator: DataValidatorProtocol {
    func validateEmail(_ value: String?) throws {
        let emailFirstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let emailServerpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = emailFirstpart + "@" + emailServerpart + "[A-Za-z]{2,6}"

        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        guard emailTest.evaluate(with: value) else {
            throw DataValidationError.invalidEmail
        }
    }

    func validateEmailMatch(_ email: String?, _ confirmEmail: String?) throws {
        guard email == confirmEmail else {
            throw DataValidationError.emailDontMatch
        }
    }

    func validateTitle(_ title: String) throws {
        guard !title.isEmpty else {
            throw DataValidationError.emptyTitle
        }
    }
}
