//
//  HistoryRowView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import SwiftUI

struct HistoryRowView: View {
    let goal: GoalLog
    
    var body: some View {
        HStack(alignment: .top) {
            icon

            Text(goal.date, style: .date)
            
            Spacer()
            
            Text(goal.goal)
                .multilineTextAlignment(.trailing)
        }
    }
    
    private var color: Color {
        if goal.isModified { return .yellow }
        if goal.isCompleted { return .green }
        return .gray
    }
    
    private var icon: some View {
        Image(systemName: goal.isCompleted ? "checkmark" : "xmark")
            .foregroundColor(color)
    }
}

#Preview {
    HistoryRowView(goal: GoalLog.sample)
}
