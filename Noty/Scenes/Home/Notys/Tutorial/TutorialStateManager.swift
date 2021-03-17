//
//  TutorialStateManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 17/3/2021.
//

import Foundation

protocol TutorialStateManagerProtocol {
    var state: TutorialState { get } // Set is open for testing purposes.

    func nextState() -> TutorialState
}

class TutorialStateManager: TutorialStateManagerProtocol {

    var state: TutorialState = .right

    func nextState() -> TutorialState {
        switch state {
        case .right: state = .left
        case .left: state = .left
        }
        return state
    }
}

enum TutorialState: Equatable {

    case right
    case left

    var title: String {
        switch self {
        case .right: return "Swipe Right"
        case .left: return "Swipe Left"
        }
    }

    var description: String {
        switch self {
        case .right: return "Swipe right for some magic 😍"
        case .left: return "Swipe left to delete Note 🤓"
        }
    }
}
