//
//  DateService.swift
//  WeatherDemoApp
//
//  Created by G G on 22.05.2023.
//

import Foundation

/// `DateService` provides utilities to work with dates.
struct DateService {
    
    // MARK: - Static properties
    
    static let calendar = Calendar.current
    
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Add this line
        return dateFormatter
    }()
    
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Static functions
    
    /// Converts a timestamp to a string day representation.
    static func convertTimestampToStringDay(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    /// Calculates the date for the next day from a given date.
    static func calculateNextDay(fromDate date: Date) -> Date {
        return calendar.date(byAdding: .day, value: 1, to: date) ?? .distantFuture
    }
    
    /// Retrieves the day component from a given date.
    static func getDayComponent(fromDate date: Date) -> Int {
        return calendar.dateComponents([.day], from: date).day ?? 0
    }
    
    /// Converts a timestamp to a full string date representation.
    static func convertTimestampToFullStringDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        return fullDateFormatter.string(from: date)
    }
}
