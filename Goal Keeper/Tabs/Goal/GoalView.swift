//
//  GoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct GoalView: View {
    let pastDeadline: Bool = false
    
    var body: some View {
        if pastDeadline {
            SetGoalView()
        } else {
            TodaysGoalView()
        }
    }
}

#Preview {
    GoalView()
}
