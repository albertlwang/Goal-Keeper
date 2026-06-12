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
