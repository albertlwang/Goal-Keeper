//
//  GoalNameText.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct GoalNameText: View {
    @Query private var activeGoals: [ActiveGoal]
    
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    var body: some View {
        if let activeGoal {
            Text(activeGoal.goal)
                .fontWeight(.medium)
                .padding(.bottom, 20)
                .strikethrough(activeGoal.isCompleted)
                .foregroundColor(activeGoal.isCompleted ? .green : .primary)
        } else {
            Text("No goal set yet.")
                .fontWeight(.medium)
                .padding(.bottom, 20)
                .foregroundColor(.primary.opacity(0.5))
        }
    }
}

#Preview {
    GoalNameText()
}
