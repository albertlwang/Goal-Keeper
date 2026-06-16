//
//  SettingsData.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import Foundation

struct SettingsData: Codable {
    var endOfDay: DateComponents        // e.g. 20:00 (10pm)
    
    var gap: TimeInterval = 8 * 60 * 60
    
    init(endOfDay: DateComponents = DateComponents(hour: 22, minute: 0)) {
        self.endOfDay = endOfDay
    }
    
    var startOfDay: DateComponents {
        var hours = endOfDay.hour! + Int(gap / 3600)
        if hours >= 24 { hours %= 24 }
        
        return DateComponents(hour: hours, minute: endOfDay.minute!)
    }
}

extension DateComponents {
    func formatted() -> String {
        let calendar = Calendar.current
        let date = calendar.date(from: self)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"  // h = 12-hour, mm = minutes, a = AM/PM
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        return formatter.string(from: date)
    }
}

extension TimeInterval {
    var hoursAndMinutes: String {
        let total = Int(self)
        let h = total / 3600
        let m = (total % 3600) / 60

        switch (h, m) {
        case (0, let m): return "\(m)m"
        case (let h, 0): return "\(h)h"
        case (let h, let m): return "\(h)h \(m)m"
        }
    }
}
