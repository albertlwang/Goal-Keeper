//
//  SettingsStore.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import Foundation

class SettingsStore {
    private let key = "settings"
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func load() -> AppSettings? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(AppSettings.self, from: data)
    }
    
    func save(_ settings: AppSettings) {
        let data = try? JSONEncoder().encode(settings)
        defaults.set(data, forKey: key)
    }
}
