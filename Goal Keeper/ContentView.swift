//
//  ContentView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Goal", systemImage: "trophy.fill") {
                GoalView()
            }
            
            Tab("History", systemImage: "calendar") {
                Text("History")
            }
            
            Tab("Settings", systemImage: "gearshape") {
                Text("Settings")
            }
        }
    }
}

#Preview {
    ContentView()
}
