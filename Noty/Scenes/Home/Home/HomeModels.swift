//
//  HomeModels.swift
//  Noty
//
//  Created by Youssef Jdidi on 14/2/2021.
//

import Foundation

enum HomeModels {
    enum RecordState {
        case isRecoding
        case isPaused
        case isCleared
    }

    enum PermissionError {
        case audio
        case speech
        case notif
    }
}
