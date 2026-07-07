//
//  EditTodaysGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

/// Handles modifications to the current active goal.
/// Presented as a sheet.
struct EditTodaysGoalView: View {
    @Environment(StateManager.self) private var stateManager
    @Environment(DataContainer.self) private var data
    @Environment(\.dismiss) private var dismiss
    
    @Query private var activeGoals: [ActiveGoal]
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    @State private var newTitle = ""
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            goalInput
                .toolbar {
                    cancelButton
                    titleLabel
                    confirmButton
                }
        }
    }
    
    // MARK: - Subviews
    
    private var goalInput: some View {
        VStack(alignment: .leading) {
            TextField(activeGoal?.title ?? "Enter title", text: $newTitle)
                .textFieldStyle(.roundedBorder)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    // MARK: - Toolbar
    
    private var cancelButton: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
    
    private var titleLabel: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Edit Goal")
        }
    }
    
    private var confirmButton: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(role: .confirm) {
                try? data.modifyCurrentActiveGoal(title: newTitle, expiresAt: stateManager.nextEOD)
                dismiss()
            }
        }
    }
}
