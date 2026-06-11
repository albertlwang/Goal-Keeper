//
//  LargeButton.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct FinishButton: View {
    @Binding var isFinished: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
            
            isFinished = true
            onTap()
            
        } label: {
            VStack {
                
                if !isFinished {
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
        .disabled(isFinished)
        .buttonStyle(.plain)
    }
}

#Preview {
    @State @Previewable var isFinished: Bool = false
    FinishButton(isFinished: $isFinished) {}
}
