//
//  GoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct GoalView: View {
    @Environment(StateManager.self) private var stateManager
    
    var body: some View {
        
        switch stateManager.currentPhase {
        case .active: TodaysGoalView()
        case .awaiting: SetGoalView()
        }
        
    }
}

#Preview {
    GoalView()
}
