//
//  GoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

/// Parent view for the goal tab.
/// Depending on the current phase, it conditionally shows the active goal
/// or the goal setting page.
struct GoalView: View {
    @Environment(StateManager.self) private var stateManager
    
    
    var body: some View {
        switch stateManager.currentPhase {
        case .active: TodaysGoalView()
        case .awaiting: SetGoalView()
        }
    }
}
