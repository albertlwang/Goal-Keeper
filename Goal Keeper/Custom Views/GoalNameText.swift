//
//  GoalNameText.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct GoalNameText: View {
    let activeGoal: ActiveGoal?
    
    
    var body: some View {
        if let activeGoal {
            Text(activeGoal.title)
                .fontWeight(.medium)
                .strikethrough(activeGoal.isCompleted)
                .foregroundColor(activeGoal.isCompleted ? .green : .primary)
            
            isModifiedTag
                .opacity(activeGoal.isModified ? 1 : 0)
                .padding(.bottom, 20)
                .padding(.top, 5)
        } else {
            Text("No goal set yet.")
                .fontWeight(.medium)
                .padding(.bottom, 20)
                .foregroundColor(.primary.opacity(0.5))
        }
    }
    
    // MARK: - Subviews
    
    private var isModifiedTag: some View {
        Text("(edited)")
            .font(.caption)
            .foregroundColor(.secondary)
            .italic(true)
    }
}
