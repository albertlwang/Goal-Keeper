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
    private(set) var title: String
    private(set) var createdAt: Date
    private(set) var expiresAt: Date
    
    private(set) var isCompleted: Bool
    private(set) var completedAt: Date?
    private(set) var isModified: Bool
    private(set) var summaryShown: Bool
    
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
    
    // MARK: - Mutation interface
    
    /// Marks the goal completed and records the completion time.
    func markCompleted(at date: Date = .now) {
        isCompleted = true
        completedAt = date
    }
    
    /// Reverts a completed goal back to incomplete, clearing its completion time.
    func markIncomplete() {
        isCompleted = false
        completedAt = nil
    }
    
    /// Updates the goal's title and flags it as modified.
    func updateTitle(_ newTitle: String) {
        title = newTitle
        isModified = true
    }
    
    /// Marks that the end-of-day summary has been presented for this goal.
    func markSummaryShown() {
        summaryShown = true
    }
}
