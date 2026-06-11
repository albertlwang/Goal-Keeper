//
//  GoalNameText.swift
//  Goal Keeper
//
//  Created by Albert Wang on 6/10/26.
//

import SwiftUI

struct GoalNameText: View {
    let text: String
    let isFinished: Bool
    
    var body: some View {
        Text(text)
            .fontWeight(.medium)
            .padding(.bottom, 20)
            .strikethrough(isFinished)
            .foregroundColor(isFinished ? .green : .primary)
    }
}

#Preview {
    GoalNameText(text: "Take out the trash.", isFinished: false)
}
