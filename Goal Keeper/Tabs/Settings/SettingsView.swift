//
//  SettingsView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppSettings.self) private var settings
    @State private var isEditingEOD = false
    @State private var eodDraft: Date = .now
    
    init() {
        UIDatePicker.appearance().minuteInterval = 15
    }
    
    var body: some View {
        // TODO: Show warning when modifying EOD to be in the past
        
        NavigationStack {
            VStack {
                List {
                    HStack {
                        Text("Day end time")
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
                    
                    if isEditingEOD {
                        @Bindable var settings = settings
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
                            .foregroundStyle(.secondary)
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
                    
                    HStack {
                        Text("Day Start Time")
                            .foregroundColor(.primary.opacity(0.5))
                        Spacer()
                        Text(settings.startOfDay.formatted())
                            .foregroundColor(.primary.opacity(0.5))
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    // SettingsView()
}
