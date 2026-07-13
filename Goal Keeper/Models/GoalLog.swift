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
///
/// Has no mutation methods by design — once created, an entry should never change.
@Model
class GoalLog {
    /// Represents the calendar day this goal is associated with.
    /// Used to show a calendar view of archived goals.
    ///
    /// Derived from ActiveGoal.startsAt = the moment the goal officially becomes active (SOD).
    /// We use the goal's associated SOD because it should fall on the morning of the
    /// day we want to display.
    private(set) var date: Date
    private(set) var title: String
    
    private(set) var isCompleted: Bool
    private(set) var completedAt: Date?
    private(set) var isModified: Bool
    
    ///Creates a historical log entry. Typically constructed from ``ActiveGoal`` at the moment it expires.
    init (from activeGoal: ActiveGoal) {
        self.date = activeGoal.startsAt
        self.title = activeGoal.title
        self.isCompleted = activeGoal.isCompleted
        self.completedAt = activeGoal.completedAt
        self.isModified = activeGoal.isModified
    }
}
