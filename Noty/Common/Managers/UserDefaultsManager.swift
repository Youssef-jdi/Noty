//
//  UserDefaultsManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 14/2/2021.
//

import UIKit

protocol UserDefaultsManagerProtocol {
    var selectedLanguage: Locale { get set }
    var email: String { get set }
    var isConnected: Bool { get set }
    var isTutoDisplayed: Bool { get set }
    var themeColor: UIColor { get set }
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    let defaults = UserDefaults.standard

    enum DefaultKeys {
        enum Settings: String {
            case language
            case email
            case isConnected
            case isTutoDisplayed
            case themeColor
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

    var themeColor: UIColor {
        get {
            return self.colorForKey(key: DefaultKeys.Settings.themeColor.rawValue)
        }
        set {
            return self.setColor(color: newValue, forKey: DefaultKeys.Settings.themeColor.rawValue)
        }
    }
}

extension UserDefaultsManager {
    private func colorForKey(key: String) -> UIColor {
        var colorReturnded: UIColor?
        if let colorData = self.defaults.data(forKey: key) {
          do {
            if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
              colorReturnded = color
            }
          } catch {
            Console.log(type: .error, "Error UserDefaults")
          }
        }
        return colorReturnded ?? R.color.vonoBlue()!
      }

      private func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
          do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
            colorData = data
          } catch {
            Console.log(type: .error, "Error UserDefaults")
          }
        }
        self.defaults.set(colorData, forKey: key)
      }
}
