//
//  SetGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct SetGoalView: View {
    @Environment(StateManager.self) private var stateManager
    @Environment(DataContainer.self) private var data
    
    @Query private var activeGoals: [ActiveGoal]
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    @State private var newTitle = ""
    @State private var isEditing = false
    @FocusState private var inputIsFocused: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                timeContext
                
                editField  // Dynamic input box
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            // Toolbar
            .navigationTitle("Set Tomorrow's Goal")
        }
        .onAppear {
            if let activeGoal {
                newTitle = activeGoal.title
            }
        }
    }
    
    // MARK: - Subviews
    
    private var timeContext: some View {
        Text("Starting in \(stateManager.timeRemaining.hoursAndMinutes)")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.bottom, 50)
    }
    
    private var editField: some View {
        Group {
            if isEditing {
                TextField("Enter Goal", text: $newTitle)
                    .textFieldStyle(.roundedBorder)
                    .focused($inputIsFocused)
                    .onAppear {
                        if let activeGoal { newTitle = activeGoal.title }
                    }
            } else {
                Text(activeGoal?.title ?? "No Goal Set")
            }
        }
        .toolbar {
            if isEditing { confirmButton }
            else { editButton }
        }
    }
    
    // MARK: - Toolbar
    
    private var editButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isEditing = true
                inputIsFocused = true
            } label: {
                Image(systemName: "pencil")
            }
        }
    }
    
    private var confirmButton: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(role: .confirm) {
                if newTitle == "" {
                    try? data.clearCurrentActiveGoal()
                } else if activeGoal?.title != newTitle {
                    /// Don't create new goal if it's the same as before.
                    try? data.setNewActiveGoal(title: newTitle)
                }
                inputIsFocused = false
                isEditing = false
            }
        }
    }
}
