//
//  Goal.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import Foundation
import SwiftData

/// An immutable historical record of a single day's goal.
///
/// `GoalLog` is the archival counterpart to ``ActiveGoal``: once a goal's day
/// ends, its final state should be copied into a `GoalLog` entry and never
/// mutated again.
@Model
class GoalLog {
    /// Represents the calendar day this goal is associated with.
    /// Used to show a calendar view of archived goals.
    ///
    /// Derived from ActiveGoal.startsAt = the moment the goal officially becomes active (SOD).
    /// We use the goal's associated SOD because it should fall on the morning of the
    /// day we want to display.
    var date: Date
    var title: String
    
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    
    ///Creates a historical log entry. Typically constructed from
    ///``ActiveGoal`` at the moment it expires.
    init (from activeGoal: ActiveGoal) {
        self.date = activeGoal.startsAt
        self.title = activeGoal.title
        self.isCompleted = activeGoal.isCompleted
        self.completedAt = activeGoal.completedAt
        self.isModified = activeGoal.isModified
    }
}
