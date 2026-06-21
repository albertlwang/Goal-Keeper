//
//  TodaysGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct TodaysGoalView: View {
    @Environment(StateManager.self) private var stateManager
    @Environment(DataContainer.self) private var data
    
    @Query private var activeGoals: [ActiveGoal]
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    @State private var isEditing: Bool = false
    
    
    var body: some View {
        NavigationStack {
            /// Content
            VStack(alignment: .leading) {
                dateContext
                
                Spacer()
                
                GoalNameText()
                
                Spacer()
                
                finishButton
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            /// Toolbar
            .navigationTitle("Today's Goal")
            .toolbar { editButton }
            .sheet(isPresented: $isEditing) { EditTodaysGoalView() }
        }
    }
    
    // MARK: - Subviews
    
    private var dateContext: some View {
        Text(Date.now.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day()))
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    
    private var finishButton: some View {
        HStack {
            Spacer()
            VStack {
                FinishButton()
                Text("\(stateManager.timeRemaining.hoursAndMinutes) left")
                    .font(.caption)
                    .foregroundColor(.secondary.opacity(
                        activeGoal == nil || activeGoal!.isCompleted ? 0 : 1
                    ))
            }
            Spacer()
        }
    }
    
    private var editButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isEditing = true
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .disabled(activeGoal != nil && activeGoal!.isCompleted)
        }
    }
}

#Preview {
    TodaysGoalView()
}
