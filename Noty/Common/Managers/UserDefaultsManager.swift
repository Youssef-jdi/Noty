//
//  UserDefaultsManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 14/2/2021.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    var selectedLanguage: Locale { get set }
    var email: String { get set }
    var isConnected: Bool { get set }
    var isTutoDisplayed: Bool { get set }
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    let defaults = UserDefaults.standard

    enum DefaultKeys {
        enum Settings: String {
            case language
            case email
            case isConnected
            case isTutoDisplayed
        }
    }
}

// MARK: Settings
extension UserDefaultsManager {
    var selectedLanguage: Locale {
        get {
            if let identifier = self.defaults.string(forKey: DefaultKeys.Settings.language.rawValue) {
                return Locale(identifier: identifier)
            } else {
                guard let deviceLanguage = NSLocale.preferredLanguages.first else { return Locale(identifier: "es-US") }
                return Locale(identifier: deviceLanguage)
            }
        }
        set {
            return self.defaults.set(newValue.identifier, forKey: DefaultKeys.Settings.language.rawValue)
        }
    }

    var email: String {
        get {
            return self.defaults.string(forKey: DefaultKeys.Settings.email.rawValue) ?? ""
        }
        set {
            return self.defaults.set(newValue, forKey: DefaultKeys.Settings.email.rawValue)
        }
    }

    var isConnected: Bool {
        get {
            return self.defaults.bool(forKey: DefaultKeys.Settings.isConnected.rawValue)
        }
        set {
            return self.defaults.set(newValue, forKey: DefaultKeys.Settings.isConnected.rawValue)
        }
    }

    var isTutoDisplayed: Bool {
        get {
            return self.defaults.bool(forKey: DefaultKeys.Settings.isTutoDisplayed.rawValue)
        }
        set {
            return self.defaults.set(newValue, forKey: DefaultKeys.Settings.isTutoDisplayed.rawValue)
        }
    }
}
