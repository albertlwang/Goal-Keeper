//
//  ContentView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(StateManager.self) private var stateManager
    
    var body: some View {
        TabView {
            Tab("Goal", systemImage: "trophy.fill") {
                GoalView()
            }
            
            Tab("History", systemImage: "calendar") {
                Text(stateManager.currentPhase.rawValue)
            }
            
            Tab("Settings", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
