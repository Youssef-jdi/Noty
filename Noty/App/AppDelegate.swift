//
//  AppDelegate.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import UIKit
import CoreData
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var app = Noty()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.disableDarkMode()
        window?.makeKeyAndVisible()
        app.prepare()
        
        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        GIDSignIn.sharedInstance().handle(url)
        return application(app,
                           open: url,
                           sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard let url = userActivity.webpageURL else { return false }
        return app.handleUniversalLink(url)
    }

    func application(
        _ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any
    ) -> Bool {
        Console.log(type: .success, url.absoluteString)
        if let dynamicLink = app.dynamicLink(fromCustomSchemeURL: url)?.url {
            return app.handleDeepLink(dynamicLink)
        }
        return false
    }
}

// MARK: For now until I figure out colors for dark theme ☹️
extension UIWindow {
    func disableDarkMode() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
    }
}
