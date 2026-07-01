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
    var title: String
    
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    
    init (date: Date, title: String, isCompleted: Bool, completedAt: Date?, isModified: Bool) {
        self.date = date
        self.title = title
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.isModified = isModified
    }
}

extension GoalLog {
    static let sample = sampleData[0]
    static let failedSample = sampleData[1]
    static let modifiedSample = sampleData[2]
    
    static let sampleData = [
        GoalLog(
            date: Date(),
            title: "Learn Swift",
            isCompleted: true,
            completedAt: Date(),
            isModified: false
        ),
        GoalLog(
            date: Date(),
            title: "Get groceries",
            isCompleted: false,
            completedAt: nil,
            isModified: false
        ),
        GoalLog(
            date: Date(),
            title: "Finish english thesis essay and turn it in.",
            isCompleted: true,
            completedAt: Date(),
            isModified: true
        ),
        GoalLog(
            date: Date(),
            title: "Talk to my friends",
            isCompleted: true,
            completedAt: Date(),
            isModified: false
        )
    ]
}
