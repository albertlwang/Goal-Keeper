//
//  EditTodaysGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct EditTodaysGoalView: View {
    @State private var newGoalDraft = ""
    @Environment(\.dismiss) private var dismiss
    
    @Query private var activeGoals: [ActiveGoal]
    @Environment(DataContainer.self) private var data
    
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    var body: some View {
        let currentGoalText = activeGoal != nil ? activeGoal!.goal : "Enter goal"
        
        NavigationStack {
            /// Content
            VStack(alignment: .leading) {
                
                TextField(currentGoalText, text: $newGoalDraft)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
  
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            /// Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Edit Goal")
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        if let activeGoal {
                            activeGoal.goal = newGoalDraft
                        } else {
                            let newGoal = ActiveGoal(goal: newGoalDraft)
                            try? data.setNewActiveGoal(newGoal)
                        }
                        activeGoal?.isModified = true
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    // EditTodaysGoalView()
}
