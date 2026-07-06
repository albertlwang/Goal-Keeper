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
    
    // MARK: - Interface
    
    // Add a new GoalLog entry to the history.
    func insertGoalLog(_ newGoal: GoalLog) throws {
        context.insert(newGoal)
        try context.save()
    }
    
    // Returns the current active goal
    // or nil if there is none.
    var activeGoal: ActiveGoal? {
        let descriptor = FetchDescriptor<ActiveGoal>()
        return try? context.fetch(descriptor).first
    }
    
    var activeGoalIsExpired: Bool {
        guard let activeGoal else { return false }
        return Date.now > activeGoal.expiresAt
    }
    
    // Erases the current active goal from context.
    // Represents no active goal.
    func clearCurrentActiveGoal() throws {
        let existing = try context.fetch(FetchDescriptor<ActiveGoal>())
        existing.forEach { context.delete($0) }
    }
    
    // Replaces the current active goal
    // given the title for a new one.
    func setNewActiveGoal(title: String, expiresAt: Date) throws {
        try clearCurrentActiveGoal()
        
        let newActiveGoal = ActiveGoal(title: title, expiresAt: expiresAt)
        context.insert(newActiveGoal)
        
        try context.save()
    }
    
    // Changes the title of a current active goal,
    // or creates a new goal with given title if none exists.
    func modifyCurrentActiveGoal(title: String, expiresAt: Date) {
        if let activeGoal {
            activeGoal.title = title
            activeGoal.isModified = true
        } else {
            try? setNewActiveGoal(title: title, expiresAt: expiresAt)
        }
    }
}
