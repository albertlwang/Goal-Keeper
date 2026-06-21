//
//  LogDetailView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/20/26.
//

import SwiftUI

struct LogDetailView: View {
    let log: GoalLog
    
    
    var body: some View {
        VStack {
            Text("Title: \(log.title)")
            
            Text("Modified: \(log.isModified ? "Yes" : "No")")
            
            Text("Completed: \(log.isCompleted ? "Yes" : "No")")
            
            Text("Time Completed: \(log.completedAt?.formatted(date: .omitted, time: .shortened) ?? "n/a")")
            
            Text("Goal Date: \(log.date.formatted(date: .numeric, time: .shortened))")
        }
    }
}
