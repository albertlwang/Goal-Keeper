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
    
    init (date: Date, goal: String, isCompleted: Bool, completedAt: Date?, isModified: Bool) {
        self.date = date
        self.goal = goal
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.isModified = isModified
    }
}

@Model
class ActiveGoal {
    var goal: String?
    var createdAt: Date
    var expiresAt: Date
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    var summaryShown: Bool
    
    init(goal: String?, createdAt: Date, expiresAt: Date) {
        self.goal = goal
        self.createdAt = createdAt
        self.expiresAt = expiresAt
        self.isCompleted = false
        self.completedAt = nil
        self.isModified = false
        self.summaryShown = false
    }
    
    var isExpired: Bool { Date.now > expiresAt }
}

extension GoalLog {
    static let sample = sampleData[0]
    static let failedSample = sampleData[1]
    static let modifiedSample = sampleData[2]
    
    static let sampleData = [
        GoalLog(
            date: Date(),
            goal: "Learn Swift",
            isCompleted: true,
            completedAt: Date(),
            isModified: false
        ),
        GoalLog(
            date: Date(),
            goal: "Get groceries",
            isCompleted: false,
            completedAt: nil,
            isModified: false
        ),
        GoalLog(
            date: Date(),
            goal: "Finish english thesis essay and turn it in.",
            isCompleted: true,
            completedAt: Date(),
            isModified: true
        ),
        GoalLog(
            date: Date(),
            goal: "Talk to my friends",
            isCompleted: true,
            completedAt: Date(),
            isModified: false
        )
    ]
}
