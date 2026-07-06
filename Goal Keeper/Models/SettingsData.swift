//
//  SettingsData.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import Foundation

/// User-configurable settings that determine when a "day" starts and ends
/// for the purposes of goal tracking.
struct SettingsData: Codable {
    
    /// The wall-clock time at which the day ends (e.g. 22:00)
    var endOfDay: DateComponents
    
    /// A hardcoded value for development purposes.
    /// Determines how long after EOD the day should start.
    /// Current value: 8 hours
    var gap: TimeInterval = 8 * 60 * 60
    
    
    /// Creates settings with a given end-of-day time, defaulting to 10:00pm
    init(endOfDay: DateComponents = DateComponents(hour: 22, minute: 0)) {
        self.endOfDay = endOfDay
    }
    
    /// The wall-clock time at which the day begins, derived from ``gap``.
    var startOfDay: DateComponents {
        var hours = (endOfDay.hour ?? 22) + Int(gap / 3600)
        if hours >= 24 { hours %= 24 }
        return DateComponents(hour: hours, minute: endOfDay.minute!)
    }
}
