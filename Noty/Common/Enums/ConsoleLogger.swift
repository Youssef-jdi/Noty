//
//  ConsoleLogger.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//

import Foundation

typealias Console = ConsoleLogger

enum ConsoleLogger {

    enum ConsoleEventType {
        case success
        case error
        case message
        case warning

        var emoji: String {
            switch self {
            case .success:
                return "🎉"
            case .error:
                return "🔴❗️"
            case .warning:
                return "⚠️"
            case .message:
                return "📩"
            }
        }
    }

    static func log(type: ConsoleEventType = .message, _ message: String) {
        print("""

            \(type.emoji) ===========================
            \(message)
            \(type.emoji) ===========================

            """)
    }
}
