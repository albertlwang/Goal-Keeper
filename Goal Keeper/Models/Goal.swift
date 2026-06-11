//
//  Goal.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import Foundation
import SwiftData

/// Defines Goal object.
/// This is what SwiftData stores for historical logs.
/// Current active Goal = whatever goal that has date = Date() --> mutate throughout the day.
/// ENFORCE: can only mutate active goal (historical logs should be static).
@Model
class GoalLog {
    var date: Date
    var goal: String
    
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    
    init (date: Date, goal: String) {
        self.date = date
        self.goal = goal
        self.isCompleted = false
        self.completedAt = nil
        self.isModified = false
    }
}
