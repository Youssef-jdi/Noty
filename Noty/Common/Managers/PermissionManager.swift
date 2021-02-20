//
//  PermissionManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import Foundation
import AVFoundation
import Speech
import EventKit

protocol PermissionManagerProtocol {
    func requestAudioPermission(_ completion: @escaping (Result<Void, PermissionManager.PermissionErrors>) -> Void)
    func requestSpeechPermission(_ completion: @escaping (Result<Void, PermissionManager.PermissionErrors>) -> Void)
}

class PermissionManager: PermissionManagerProtocol {
    enum PermissionErrors: Error {
        case noSpeechAccess
        case speechNotDetermined

        case noAudioAccess
        case audioNotDetermined

        case noNoteAccess
        case noteNotDetermined
    }

    func requestAudioPermission(_ completion: @escaping (Result<Void, PermissionErrors>) -> Void) {
        do {
            try checkAudioPermission()
            completion(.success(()))
        } catch {
            guard let error = error as? PermissionErrors else { return }
            switch error {
            case .audioNotDetermined:
                AVCaptureDevice.requestAccess(for: .audio) { isAuthorized in
                    if isAuthorized {
                        completion(.success(()))
                    } else {
                        completion(.failure(PermissionErrors.noAudioAccess))
                        return
                    }
                }

            case .noAudioAccess:
                completion(.failure(error))

            default: break
            }
        }
    }

    private func checkAudioPermission() throws {
        let audioAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch audioAuthorizationStatus {
        case .authorized: break
        case .notDetermined: throw PermissionErrors.audioNotDetermined
        default: throw PermissionErrors.noAudioAccess
        }
    }

    func requestSpeechPermission(_ completion: @escaping (Result<Void, PermissionErrors>) -> Void) {
        do {
            try checkSpeechPermission()
            completion(.success(()))
        } catch {
            guard let error = error as? PermissionErrors else { return }
            switch error {
            case .speechNotDetermined:
                SFSpeechRecognizer.requestAuthorization { status in
                    switch status {
                    case .authorized:
                        completion(.success(()))

                    default:
                        completion(.failure(PermissionErrors.noSpeechAccess))
                    }
                }

            case .noSpeechAccess:
                completion(.failure(error))

            default: break
            }
        }
    }

    private func checkSpeechPermission() throws {
        let speechStatus = SFSpeechRecognizer.authorizationStatus()
        switch speechStatus {
        case .authorized: break
        case .notDetermined: throw PermissionErrors.speechNotDetermined
        default: throw PermissionErrors.noSpeechAccess
        }
    }
}
