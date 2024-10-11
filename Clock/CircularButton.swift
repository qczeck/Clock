//
//  CircularButton.swift
//  Clock
//
//  Created by Maciej Kuczek on 17/12/2021.
//

import SwiftUI

struct CircularButton: View {
    var labelText: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(color)
                    .opacity(DrawingConstants.buttonOpacity)
                Circle()
                    .scale(0.95)
                    .stroke(.black, lineWidth: 2)
                Text(labelText)
                    .foregroundColor(color)
            }
        }
        .frame(width: DrawingConstants.buttonSize, height: DrawingConstants.buttonSize)
    }
    
    init(_ labelText: String, color: Color, action: @escaping () -> Void) {
        self.labelText = labelText
        self.action = action
        self.color = color
    }
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularButton("Start", color: .green, action: {})
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        CircularButton("Lap", color: .gray, action: {})
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
