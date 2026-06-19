//
//  SetGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct SetGoalView: View {
    @Environment(DataContainer.self) private var data
    
    @Query private var activeGoals: [ActiveGoal]
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    @State private var newGoal = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Starting in 9h")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 50)
                
                if isEditing {
                    editField
                } else {
                    displayGoal
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            // Toolbar
            .navigationTitle("Set Tomorrow's Goal")
        }
        .onAppear {
            if let activeGoal {
                newGoal = activeGoal.goal
            }
        }
    }
    
    private var editField: some View {
        TextField(activeGoal != nil ? activeGoal!.goal : "Enter Goal", text: $newGoal)
            .textFieldStyle(.roundedBorder)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        if let activeGoal {
                            activeGoal.goal = newGoal
                        } else {
                            try? data.setNewActiveGoal(ActiveGoal(goal: newGoal))
                        }
                        isEditing = false
                    }
                }
            }
    }
    
    private var displayGoal: some View {
        Text(activeGoal != nil ? activeGoal!.goal : "No Goal Set")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing = true
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
    }
}

#Preview {
    // SetGoalView()
}
