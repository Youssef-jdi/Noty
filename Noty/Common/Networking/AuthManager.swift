//
//  AuthManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/2/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import Firebase

protocol AuthManagerProtocol {
    func signInWithEmail(email: String, completion: @escaping ((Result<Void, Error>) -> Void))
    func confirmSignIn(with link: String, _ completion: @escaping ((Result<Void, FirebaseError>) -> Void))
    func prepareGoogleSignIn()
}
class AuthManager: NSObject, AuthManagerProtocol {

    private var userDefaultManager: UserDefaultsManagerProtocol

    init(userDefaultManager: UserDefaultsManagerProtocol) {
        self.userDefaultManager = userDefaultManager
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
    }

    func signInWithEmail(email: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        let actionCodeSettings = ActionCodeSettings()
        let scheme = "https"
        let uriPrefix = "notys.page.link"
        let queryItemEmailName = "email"
        var components = URLComponents()
        components.scheme = scheme
        components.host = uriPrefix

        let emailTypeQueryItem = URLQueryItem(name: queryItemEmailName, value: email)
        components.queryItems = [emailTypeQueryItem]

        guard let linkParameter = components.url else { return }
        Console.log(type: .warning, linkParameter.absoluteString)

        actionCodeSettings.url = linkParameter
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)

        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) {[weak self] err in
            guard let self = self else { return }
            if let err = err {
                Console.log(type: .error, err.localizedDescription)
                completion(.failure(err))
                return
            }
            Console.log(type: .success, "Successfully sent sign in link")
            self.userDefaultManager.email = email
            completion(.success(()))
        }
    }

    func confirmSignIn(with link: String, _ completion: @escaping ((Result<Void, FirebaseError>) -> Void)) {
        if Auth.auth().isSignIn(withEmailLink: link) {
            let email = userDefaultManager.email
            Auth.auth().signIn(withEmail: email, link: link) {[weak self] result, error in
                guard let self = self else { return }
                if let error = error {
                    Console.log(type: .error, "Error while signin in with error: \(error.localizedDescription)")
                    completion(.failure(.signingIn(error)))
                    return
                }
                guard let _ = result else {
                    Console.log(type: .error, "Error Signing in")
                    completion(.failure(.errorOccured))
                    return
                }
                self.userDefaultManager.isConnected = true
                completion(.success(()))
            }
        }
    }

    private func addUser(result: AuthDataResult, email: String, _ completion: @escaping ((Result<Void, Error>) -> Void)) {
        let uid = result.user.uid
        let data = [
            "uid": uid,
            "createdAt": FieldValue.serverTimestamp(),
            "email": email
        ] as [String: Any]
        Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .setData(data) { error in
                if let error = error {
                    Console.log(type: .error, "Failing adding document to Firebase")
                    completion(.failure(error))
                    return
                }
                Console.log(type: .success, "Success adding document to Firebase")
                completion(.success(()))
            }
    }

    func prepareGoogleSignIn() {
        GIDSignIn.sharedInstance()?.delegate = self
    }
}

extension AuthManager: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            Console.log(type: .error, "Error occured: \(error)")
            if error._code != -5 {
                Console.log(type: .error, "Error occured signing in: \(error)")
            }
            return
        } else {
            Console.log(type: .success, user.profile.email)
            self.signInWithEmail(email: user.profile.email) { result in
                switch result {
                case .success: NotificationCenter.default.post(name: emailSent, object: user.profile.email)
                case .failure(let error): NotificationCenter.default.post(name: emailSent, object: error)
                }
            }
        }
    }
}
