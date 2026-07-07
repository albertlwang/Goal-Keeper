//
//  HistoryRowView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/11/26.
//

import SwiftUI

/// Summary row view for each archived goal.
struct HistoryRowView: View {
    let log: GoalLog
    
    
    var body: some View {
        HStack(alignment: .top) {
            icon

            Text(log.date, style: .date)
            
            Spacer()
            
            Text(log.title)
                .multilineTextAlignment(.trailing)
        }
    }
    
    // MARK: - Computed Properties
    
    private var color: Color {
        if log.isModified { return .yellow }
        if log.isCompleted { return .green }
        return .gray
    }
    
    private var icon: some View {
        Image(systemName: log.isCompleted ? "checkmark" : "xmark")
            .foregroundColor(color)
    }
}
