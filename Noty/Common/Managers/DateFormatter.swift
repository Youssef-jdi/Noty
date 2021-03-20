//
//  DateFormatter.swift
//  Noty
//
//  Created by Youssef Jdidi on 20/3/2021.
//

import Foundation

protocol DateFormatterProtocol {
    func currentDate() -> Date
    func get(date: Date?, in format: String) -> String
}

class DateFormatterManager: DateFormatterProtocol {
    private lazy var formatter = DateFormatter()

    func get(date: Date?, in format: String) -> String {
        guard let date = date else { return "Invalid date" }
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func currentDate() -> Date {
        return getDateInCurrentTimeZone(Date())
    }

    func getDateInCurrentTimeZone(_ date: Date) -> Date {
        let timezoneOffset = TimeZone.current.secondsFromGMT()
        let epochDate = date.timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }
}
