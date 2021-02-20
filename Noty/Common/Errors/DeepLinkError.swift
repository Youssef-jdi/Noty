//
//  DeepLinkError.swift
//  Noty
//
//  Created by Youssef Jdidi on 19/2/2021.
//

import Foundation

enum DeepLinkError: AppError {

    case caseNotSupported
    case wrongFormat
    case invalidLink

    var title: String { return "Deep link error" }
    var description: String {
        switch self {
        case .caseNotSupported:
            return "Deeplink not supported error"
        case .invalidLink:
            return "Deeplink invalid link error"
        case .wrongFormat:
            return "Deeplink wrong format error"
        }
    }
}
