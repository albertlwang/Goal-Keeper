//
//  Goal.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import Foundation
import SwiftData

/// Database definition that stores all historical goal logs.
@Model
class GoalLog {
    var date: Date
    var goal: String
    
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    
    init (date: Date, goal: String, isCompleted: Bool, completedAt: Date?, isModified: Bool) {
        self.date = date
        self.goal = goal
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.isModified = isModified
    }
}

/// Object representing a currently active goal.
/// Convert to GoalLog shape upon EOD.
struct ActiveGoal {
    let date: Date
    let goal: String
    let isCompleted: Bool
}
