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
            logItems
                .navigationTitle("History")
        }
    }
    
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
}

#Preview {
    HistoryView()
        .sampleDataContainer()
}
