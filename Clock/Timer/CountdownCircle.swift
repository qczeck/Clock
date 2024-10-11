//
//  CountdownCircle.swift
//  Clock
//
//  Created by Maciej Kuczek on 17/12/2021.
//

import SwiftUI

struct CountdownCircle: View {
    var degrees: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))
                .opacity(0.2)
            CountdownCircleShape(degrees: degrees)
                .stroke(.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        }
    }
}

struct CountdownCircleShape: Shape {
    var degrees: Double
    
    var animatableData: Double {
        get { degrees }
        set { degrees = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.size.width/2, startAngle: .degrees(degrees-90), endAngle: .degrees(270), clockwise: true)
        return path
    }
}

struct CountdownCircle_Previews: PreviewProvider {
    static var previews: some View {
        CountdownCircle(degrees: 50)
            .preferredColorScheme(.dark)
    }
}
