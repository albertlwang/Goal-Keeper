//
//  HistoryView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \GoalLog.date) private var goals: [GoalLog]
    
    
    var body: some View {
        NavigationStack {
            Group {
                if goals.isEmpty { placeholder }
                else { logItems }
            }
            .navigationTitle("History")
        }
    }
    
    // MARK: - Subviews
    
    private var logItems: some View {
        List {
            ForEach(goals) { goal in
                NavigationLink {
                    GoalView()
                } label: {
                    HistoryRowView(goal: goal)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationLinkIndicatorVisibility(.hidden)
    }
    
    private var placeholder: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("No history yet. Set a goal at night to start tracking.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    HistoryView()
}
