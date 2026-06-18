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
                
                Text(Date.now.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day()))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                GoalNameText()
                    .onAppear {
                        // try? data.setNewActiveGoal(nil)
                    }
                
                Spacer()
                
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
                
                Spacer()
  
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            /// Toolbar
            .navigationTitle("Today's Goal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .disabled(activeGoal != nil && activeGoal!.isCompleted)
                }
            }
            .sheet(isPresented: $isEditing) {
                EditTodaysGoalView()
            }
        }
    }
}

#Preview {
    TodaysGoalView()
}
