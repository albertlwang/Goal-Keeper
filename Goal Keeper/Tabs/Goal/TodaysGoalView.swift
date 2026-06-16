//
//  TodaysGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct TodaysGoalView: View {
    @Environment(StateManager.self) private var stateManager
    @State var isFinished: Bool = false
    
    var body: some View {
        NavigationStack {
            /// Content
            VStack(alignment: .leading) {
                
                Text(Date.now.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day()))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                GoalNameText(text: "Take out the trash.", isFinished: isFinished)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        FinishButton(isFinished: $isFinished) {}
                        Text("\(stateManager.timeRemaining.hoursAndMinutes) left")
                            .font(.caption)
                            .foregroundColor(.secondary.opacity(isFinished ? 0 : 1))
                    }
                    
                    Spacer()
                }
                
                
                Spacer()
  
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            /// Toolbar
            .navigationTitle("Today's Goal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {
    TodaysGoalView()
}
