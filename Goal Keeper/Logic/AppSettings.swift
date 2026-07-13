//
//  AppSettings.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/12/26.
//

import Foundation

@Observable
final class AppSettings {
    
    static let shared = AppSettings()
    
    private static let key = "appSettings"
    
    var data: SettingsData {
        didSet { save() }
    }
    
    private init() {
        if let stored = UserDefaults.standard.data(forKey: Self.key),
           let decoded = try? JSONDecoder().decode(SettingsData.self, from: stored) {
            data = decoded
        } else {
            data = SettingsData()
        }
    }
    
    // MARK: - Interface
    
    var endOfDay: DateComponents {
        get { data.endOfDay }
        set { data.endOfDay = newValue }
    }
    
    var startOfDay: DateComponents {
        get { data.startOfDay }
    }
    
    // MARK: - Private Functions
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: Self.key)
        }
    }
    
    func reset() {
        data = SettingsData()
    }
}

extension AppSettings {
    // Converts DateComponents <-> Date for DatePicker binding
    var endOfDayAsDate: Date {
        get {
            Calendar.current.date(from: data.endOfDay)
            ?? Calendar.current.date(bySettingHour: data.endOfDay.hour ?? 22,
                                     minute: data.endOfDay.minute ?? 0,
                                     second: 0, of: .now)
            ?? .now
        }
        set {
            let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
            data.endOfDay = components
        }
    }
}
