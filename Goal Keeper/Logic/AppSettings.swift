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
    
    var endOfDay: DateComponents {
        get { data.endOfDay }
        set { data.endOfDay = newValue }
    }
    var startOfDay: DateComponents {
        get { data.startOfDay }
    }
    
    private init() {
        if let stored = UserDefaults.standard.data(forKey: Self.key),
           let decoded = try? JSONDecoder().decode(SettingsData.self, from: stored) {
            data = decoded
        } else {
            data = SettingsData()
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: Self.key)
        }
    }
    
    func reset() {
        data = SettingsData()
    }
}
