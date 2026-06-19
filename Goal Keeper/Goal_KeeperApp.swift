//
//  Goal_KeeperApp.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

@main
struct Goal_KeeperApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(DataContainer.shared)
                .environment(StateManager.shared)
                .environment(AppSettings.shared)
        }
        .modelContainer(DataContainer.shared.modelContainer)
    }
}
