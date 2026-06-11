//
//  AppSettings.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import Foundation

struct AppSettings: Codable {
    var endOfDay: DateComponents        // e.g. 20:00 (10pm)
    var startOfDay: DateComponents
}
