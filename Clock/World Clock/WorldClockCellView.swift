//
//  WorldClockCellView.swift
//  Clock
//
//  Created by Maciej Kuczek on 20/12/2021.
//

import SwiftUI

struct WorldClockCellView: View {
    let timeZoneIdentifier: String
    let hidingTimeCondition: () -> Bool
    
    @State private var currentTime = ""
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(_ timeZoneIdentifier: String, hidingTimeCondition: @escaping () -> Bool) {
        self.timeZoneIdentifier = timeZoneIdentifier
        self.hidingTimeCondition = hidingTimeCondition
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(WorldClockStore.timeDifference(timeZoneIdentifier) ?? "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(WorldClockStore.displayableTimeZoneIdentifier(timeZoneIdentifier))
                    .font(.title)
                    
            }
            .layoutPriority(1)
            Spacer()
            Text(currentTime)
                .font(.system(size: 60))
                .fontWeight(.light)
                .onReceive(timer) { _ in
                    currentTime = WorldClockStore.timeIn(timeZoneIdentifier)
                }
                .onAppear {
                    currentTime = WorldClockStore.timeIn(timeZoneIdentifier)
                }
                .lineLimit(1)
                .opacity(hidingTimeCondition() ? 0 : 1)
        }
    }
}

struct WorldClockCellView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockCellView("Europe/Berlin", hidingTimeCondition: { false })
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
