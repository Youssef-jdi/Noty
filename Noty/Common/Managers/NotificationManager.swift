//
//  NotificationManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 22/3/2021.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    func scheduleNotification(note: NoteModel, on date: Date, _ completion: @escaping (Result<Void, Error>) -> Void)
}

class NotificationManager: NotificationManagerProtocol {
    private let notificationCenter = UNUserNotificationCenter.current()
    private let options: UNAuthorizationOptions = [.alert, .sound, .badge]

    #warning("will make user choose notification sound 😎")
    func scheduleNotification(note: NoteModel, on date: Date, _ completion: @escaping (Result<Void, Error>) -> Void) {
        let content = UNMutableNotificationContent()
        content.body = note.text
        content.subtitle = "Subtitle"
        content.title = "Did you forget something 🙄"
       // content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: R.file.cowMp3.name.appending(".mp3")))
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: R.file.naughtyMp3.name.appending(".mp3")))
        content.badge = 1
        
        let calender = Calendar.current.date(byAdding: .day, value: 0, to: date)
        guard let calendarUnwarped = calender else { return }
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: calendarUnwarped)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        guard let id = note.id else { return }
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger)

        notificationCenter.add(request) { error in
            guard let error = error else {
                Console.log(type: .success, "Success notification added on \(dateComponents.debugDescription)")
                completion(.success(()))
                return
            }
            Console.log(type: .error, error.localizedDescription)
            completion(.failure(error))
        }
    }
}
