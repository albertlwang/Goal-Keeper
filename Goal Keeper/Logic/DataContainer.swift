//
//  DataContainer.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    static let shared = DataContainer()
    
    let modelContainer: ModelContainer
    var context: ModelContext { modelContainer.mainContext }
    
    init() {
        let schema = Schema([GoalLog.self, ActiveGoal.self])
        let modelConfiguration = ModelConfiguration(schema: schema)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }
    
    // MARK: - Queries
    
    /// The current active goal, or `nil` if there is none.
    var activeGoal: ActiveGoal? {
        let descriptor = FetchDescriptor<ActiveGoal>()
        return try? context.fetch(descriptor).first
    }
    
    /// Whether the active goal's day has ended.
    var activeGoalIsExpired: Bool {
        guard let activeGoal else { return false }
        return Date.now > activeGoal.expiresAt
    }
    
    // MARK: - Active goal lifecycle
    
    /// Replaces the current active goal with a new one.
    func setNewActiveGoal(title: String, expiresAt: Date) throws {
        try clearCurrentActiveGoal()
        context.insert(ActiveGoal(title: title, expiresAt: expiresAt))
        try context.save()
    }
    
    /// Updates the title of the current active goal, or creates one if none exists.
    /// - Note:`expiresAt` is only used if a new goal must be created; it has
    /// no effect if an active goal already exists.
    func modifyCurrentActiveGoal(title: String, expiresAt: Date) throws {
        if let activeGoal {
            activeGoal.updateTitle(title)
            try context.save()
        } else {
            try setNewActiveGoal(title: title, expiresAt: expiresAt)
        }
    }
    
    /// Marks the current active goal completed. No-op if there is none.
    func completeActiveGoal() throws {
        activeGoal?.markCompleted()
        try context.save()
    }
    
    /// Marks the current active goal incomplete. No-op if there is none.
    func uncompleteActiveGoal() throws {
        activeGoal?.markIncomplete()
        try context.save()
    }
    
    /// Deletes the current active goal without archiving it.
    /// - Warning: This is destructive with no history retained. Prefer
    /// ``archiveExpiredActiveGoal()`` unless specifically meaning to discard.
    func clearCurrentActiveGoal() throws {
        let existing = try context.fetch(FetchDescriptor<ActiveGoal>())
        existing.forEach { context.delete($0) }
        try context.save()
    }
    
    /// Archives the current active goal into `GoalLog` history and clears it,
    /// as a single atomic operation. No-op if no active goal.
    func archiveExpiredActiveGoal() throws {
        guard let activeGoal else { return }
        context.insert(GoalLog(from: activeGoal))
        context.delete(activeGoal)
        try context.save()
    }
}
