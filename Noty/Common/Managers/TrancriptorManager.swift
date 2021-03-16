//
//  TrancriptorManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 12/2/2021.
//

import AVFoundation
import Speech
import AudioKit

protocol TranscriptorManagerProtocol {

    var delegate: SpeechTranscriptionDelegate? { get set }

    func prepare()
    func startRecording()
    func pauseRecording()
    func getCurrentAmplitude() -> Double
    func tearDown()
}

protocol SpeechTranscriptionDelegate: class {

    /// Called when any error occurs during the speech transcription
    ///
    /// - Parameters:
    ///   - error: that occurs in preparation of or during audio transcription
    func transcriptor(failedWithError error: Error)

    /// Called when the transcriptor recognises and transcripts voice
    ///
    /// - Parameters:
    ///   - transcription: the most accurate voice-to-text transcription
    ///   - completed: when true, the audio task has finished transcripting, and you must start again.
    func transcriptor(didTranscript transcription: String, completed: Bool)
}

class TranscriptorManager: TranscriptorManagerProtocol {
    enum TranscriptorManagerState {
        case initialized

        case idle
        case prepare
        case ready

        case isRecording
        case isPaused

        case clear
    }

    private let audioEngine: AVAudioEngine
    private var speechRecognizer: SFSpeechRecognizer?
    private let recorderManager: RecorderManagerProtocol
    private let userDefaultManager: UserDefaultsManagerProtocol
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    weak var delegate: SpeechTranscriptionDelegate?

    init(
        recorderManager: RecorderManagerProtocol,
        userDefaultManager: UserDefaultsManagerProtocol
    ) {
        self.audioEngine = AVAudioEngine()
        self.recorderManager = recorderManager
        self.userDefaultManager = userDefaultManager
    }

    func prepare() {
        self.speechRecognizer = SFSpeechRecognizer(locale: self.userDefaultManager.selectedLanguage)
        self.recorderManager.setupComponents()
        print("SFSpeechRecognizer Language \(self.userDefaultManager.selectedLanguage.identifier)")
        do {
            try AKSettings.session.setPreferredSampleRate(AKSettings.session.sampleRate)
            self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            self.bindRecognitionTask()
            self.audioEngine.inputNode.removeTap(onBus: 0)

            let sampleRate = self.audioEngine.inputNode.inputFormat(forBus: 0).sampleRate
            let recordingFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
            self.audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1_024, format: recordingFormat) { buffer, _ in
                self.recognitionRequest?.append(buffer)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func bindRecognitionTask() {
        guard let recognitionRequest = recognitionRequest else { return }
        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: {[weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                let transcripted = result.bestTranscription.formattedString
                self.delegate?.transcriptor(didTranscript: transcripted, completed: result.isFinal)
                if result.isFinal {
                    // display end result
                    // self?.disposeExistingTask()
                }
            } else if let error = error {
                self.delegate?.transcriptor(failedWithError: error)
            }
        })
    }

    private func startEngine() {
        if !audioEngine.isRunning {
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("It's running bitch")
        }
    }

    func tearDown() {
        recorderManager.clear()
        self.speechRecognizer = nil
        self.audioEngine.reset()
        self.audioEngine.stop()
    }
}

extension TranscriptorManager {
    func startRecording() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else { return }
            self.recorderManager.startRecording()
            self.startEngine()
        }
    }

    func pauseRecording() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.recorderManager.pauseRecording()
            self.audioEngine.stop()
        }
    }

    func getCurrentAmplitude() -> Double {
        return recorderManager.getCurrentAmplitude()
    }
}
