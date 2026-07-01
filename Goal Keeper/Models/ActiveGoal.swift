//
//  ActiveGoal.swift
//  Goal Keeper
//
//  Created by Albert Wang on 7/1/26.
//

import Foundation
import SwiftData

@Model
class ActiveGoal {
    var title: String
    var createdAt: Date
    var expiresAt: Date
    
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    var summaryShown: Bool
    
    init(title: String, expiresAt: Date) {
        self.title = title
        self.expiresAt = expiresAt
        
        self.createdAt = .now
        self.isCompleted = false
        self.completedAt = nil
        self.isModified = false
        self.summaryShown = false
    }
}
