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
    let modelContainer: ModelContainer
    
    var context: ModelContext { modelContainer.mainContext }
    
    init(includeSampleData: Bool = false) {
        let schema = Schema([GoalLog.self, ActiveGoal.self])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleData)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            if includeSampleData {
                loadSampleData()
            }
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }
    
    // MARK: - Interface
    func insertGoalLog(_ newGoal: GoalLog) throws {
        context.insert(newGoal)
        try context.save()
    }
    
    var activeGoal: ActiveGoal? {
        let descriptor = FetchDescriptor<ActiveGoal>()
        return try? context.fetch(descriptor).first
    }
    
    func setNewActiveGoal(_ newActiveGoal: ActiveGoal?) throws {
        // Delete any existing instance
        let existing = try context.fetch(FetchDescriptor<ActiveGoal>())
        existing.forEach { context.delete($0) }
        
        // Insert the new one if provided
        if let newActiveGoal {
            context.insert(newActiveGoal)
        }
        
        try context.save()
    }
    
    // MARK: - Sample Data
    
    private func loadSampleData() {
        for goal in GoalLog.sampleData {
            context.insert(goal)
        }
    }
}

private let sampleContainer = DataContainer(includeSampleData: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
