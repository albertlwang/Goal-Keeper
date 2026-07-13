//
//  SettingsView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(DataContainer.self) private var data
    @Environment(AppSettings.self) private var settings
    
    @State private var isEditingEOD = false
    @State private var eodDraft: Date = .now
    
    init() {
        UIDatePicker.appearance().minuteInterval = 15
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    eodEditor
                    if isEditingEOD { datePicker }
                    
                    sodDisplayer
                    
                    Section(header: Text("Debug")) {
                        clearActiveGoalButton
                        printActiveGoalButton
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    // MARK: - Subviews
    
    private var eodEditor: some View {
        HStack {
            Text("Day End Time")
            Spacer()
            Button {
                eodDraft = settings.endOfDayAsDate
                withAnimation { isEditingEOD = true }
            } label: {
                Text(settings.endOfDay.formatted())
                    .foregroundColor(isEditingEOD ? .primary : .blue)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var datePicker: some View {
        Group {
            DatePicker(
                "",
                selection: $eodDraft,
                displayedComponents: .hourAndMinute,
            )
            .datePickerStyle(.wheel)
            
            HStack {
                Button("Cancel") {
                    withAnimation { isEditingEOD = false }
                }
                .foregroundStyle(.red)
                .buttonStyle(.plain)
                
                Spacer()
                
                Button("Confirm") {
                    withAnimation { isEditingEOD = false }
                    settings.endOfDayAsDate = eodDraft
                }
                .fontWeight(.medium)
                .buttonStyle(.plain)
                .foregroundColor(.blue)
            }
            .padding(.vertical, 4)
        }
    }
    
    private var sodDisplayer: some View {
        HStack {
            Text("Day Start Time")
                .foregroundColor(.primary.opacity(0.5))
            Spacer()
            Text(settings.startOfDay.formatted())
                .foregroundColor(.primary.opacity(0.5))
        }
    }
    
    // MARK: - Debug Buttons
    #if DEBUG
    private var clearActiveGoalButton: some View {
        Button("Clear active goal") {
            do {
                try data.clearCurrentActiveGoal()
            } catch {
                print("Failed to clear active goal: ", error)
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.accentColor)
    }
    
    private var printActiveGoalButton: some View {
        Button("Print active goal") {
            if let activeGoal = data.activeGoal {
                print(activeGoal)
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.accentColor)
    }
    #endif
}

#Preview {
    // SettingsView()
}
