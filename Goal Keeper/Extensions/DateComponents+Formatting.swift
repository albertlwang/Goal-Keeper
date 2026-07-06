//
//  DateComponents+Formatting.swift
//  Goal Keeper
//
//  Created by Albert Wang on 7/6/26.
//

import Foundation

extension DateComponents {
    /// A cached static formatter.
    /// Avoids reinitiallizing a new DateFormatter each time ``formatted()`` is called.
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"  // h = 12-hour, mm = minutes, a = AM/PM
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }()
    
    /// Formats components as a 12-hour clock time, e.g. "10:00pm"
    /// Returns "--:--" if `self` cannot be resolved to a valid date (e.g. missing hour or minute)
    func formatted() -> String {
        let calendar = Calendar.current
        guard let date = calendar.date(from: self) else {
            return "--:--"
        }
        
        return Self.timeFormatter.string(from: date)
    }
}
