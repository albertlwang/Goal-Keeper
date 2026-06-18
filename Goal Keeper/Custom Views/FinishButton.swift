//
//  LargeButton.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI
import SwiftData

struct FinishButton: View {
    @Environment(DataContainer.self) private var data
    @Query private var activeGoals: [ActiveGoal]
    
    private var activeGoal: ActiveGoal? { activeGoals.first }
    
    var body: some View {
        Button {
            if let activeGoal {
                activeGoal.isCompleted = true
                try? data.context.save()
            }
            
        } label: {
            VStack {
                
                if activeGoal == nil || !activeGoal!.isCompleted {
                    Text("Finish")
                } else {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                }
                
            }
            .frame(width: 300, height: 70)
            .background {
                
                Capsule()
                    .fill(.primary.opacity(0.1))
                
            }
        }
        .disabled(activeGoal == nil || activeGoal!.isCompleted)
        .buttonStyle(.plain)
    }
}

#Preview {
    // FinishButton()
}
