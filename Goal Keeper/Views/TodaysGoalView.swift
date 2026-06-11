//
//  TodaysGoalView.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct TodaysGoalView: View {
    @State var isFinished: Bool = false
    
    
    var body: some View {
        NavigationStack {
            /// Content
            VStack(alignment: .leading) {
                
                Text("Wed Jun 11")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                GoalNameText(text: "Take out the trash.", isFinished: isFinished)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        FinishButton(isFinished: $isFinished) {}
                        Text("3h 21m left")
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
