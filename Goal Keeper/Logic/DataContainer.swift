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
        let schema = Schema([GoalLog.self])
        
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
