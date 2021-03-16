//
//  RecorderManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import Foundation
import AudioKit

protocol RecorderManagerProtocol {
    func setupComponents()
    func startRecording()
    func pauseRecording()
    func getCurrentAmplitude() -> Double
    func clear()
}

class RecorderManager: RecorderManagerProtocol {
    enum RecorderManagerState {
        case initialized
        case idle
        case prepare
        case ready
        case isRecording
        case isPaused
        case clear
    }

    private(set) var tracker: AKFrequencyTracker?
    private(set) var microphone: AKMicrophone?
    private(set) var silence: AKBooster?
    private(set) var recorder: AKNodeRecorder?

    func setupComponents() {
        do {
            // Activate audio session
            try self.activateAudioSession()

            // Set sample rate
            try AKSettings.session.setPreferredSampleRate(AKSettings.session.sampleRate)

            // Initialize component
            self.microphone = AKMicrophone()
            self.tracker = .init(self.microphone)
            self.silence = .init(self.tracker, gain: 0)
            self.recorder = try AKNodeRecorder(node: self.microphone)

            // Reset recorder
            try self.recorder?.reset()

            // Start Audio Kit
            self.startComponent()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func startComponent() {
        do {
            AKManager.output = silence
            try AKManager.start()
            microphone?.start()
            tracker?.start()
        } catch {
            print(error)
        }
    }

    private func stopComponent() {
        do {
            tracker?.stop()
            microphone?.stop()
            try AKManager.stop()
        } catch {
            print(error)
        }
    }

    func clear() {
        do {
            self.recorder?.stop()
            try self.recorder?.reset()

            try self.deactivateAudioSession()
        } catch {
            print(error)
        }
    }

    private func activateAudioSession() throws {
        var options: AVAudioSession.CategoryOptions = []
        AKSettings.useBluetooth = true
        options.insert(.allowBluetooth)
        options.insert(.allowBluetoothA2DP)
        options.insert(.duckOthers)

        try AKSettings.session.setCategory(.playAndRecord, options: options)
        try AKSettings.session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func deactivateAudioSession() throws {
        // Stop Audio Kit
        stopComponent()
        // Deinitialize
        self.silence = nil
        self.tracker = nil
        self.microphone = nil
        self.recorder = nil
        // Deactivate session
        try AKSettings.session.setActive(false, options: .notifyOthersOnDeactivation)
    }

    func startRecording() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else { return }
            do {
                try self.activateAudioSession()
                try AKManager.start()
                try self.recorder?.record()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func pauseRecording() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                self.recorder?.stop()
                try AKManager.stop()
                try AKSettings.session.setActive(false, options: .notifyOthersOnDeactivation)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getCurrentAmplitude() -> Double {
        return tracker?.amplitude ?? 0
    }
}
