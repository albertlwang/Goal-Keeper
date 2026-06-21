//
//  HistoryView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \GoalLog.date, order: .reverse) private var logs: [GoalLog]
    
    
    var body: some View {
        NavigationStack {
            Group {
                if logs.isEmpty { placeholder }
                else { logItems }
            }
            .navigationTitle("History")
        }
    }
    
    // MARK: - Subviews
    
    private var logItems: some View {
        List {
            ForEach(logs) { log in
                NavigationLink {
                    LogDetailView(log: log)
                } label: {
                    HistoryRowView(log: log)
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
