//
//  ActiveGoal.swift
//  Goal Keeper
//
//  Created by Albert Wang on 7/1/26.
//

import Foundation
import SwiftData

/// The single goal the user is currently working toward.
///
/// There should only ever be one `ActiveGoal` live at a time. It represents
/// today's (or the upcoming day's) goal and is mutated freely as the user makes progress.
/// Once its day ends (see ``expiresAt``), it is expected to be archived into a ``GoalLog``
/// entry and either cleared or replaced with a new `ActiveGoal`.
///
/// - Note: Unlike ``GoalLog``, which is an immutable historical record, `ActiveGoal`
/// is the mutable, "live" representation of the same underlying concept.
@Model
class ActiveGoal {
    var title: String
    var createdAt: Date
    var expiresAt: Date
    
    var isCompleted: Bool
    var completedAt: Date?
    var isModified: Bool
    var summaryShown: Bool
    
    /// Creates a new active goal.
    init(title: String, expiresAt: Date) {
        self.title = title
        self.expiresAt = expiresAt
        
        self.createdAt = .now
        self.isCompleted = false
        self.completedAt = nil
        self.isModified = false
        self.summaryShown = false
    }
    
    /// The official start of this goal's day, derived as 8 hours before ``expiresAt``.
    var startsAt: Date {
        Calendar.current.date(byAdding: .hour, value: -8, to: expiresAt) ?? .now
    }
}
