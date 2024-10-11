//
//  AlarmListCell.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import SwiftUI

struct AlarmListCell: View {
    @Binding var alarm: Alarm

    var onTapGesture: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(alarm.time, style: .time)
                        .font(.system(size: 60))
                        .fontWeight(.light)
                    Text(alarm.label)
                        .font(.footnote)
                    + Text(!alarm.whenRepeated.isEmpty ? ", \(AlarmStore.repeatLabel(alarm.whenRepeated))" : "")
                        .font(.footnote)
                }
                .opacity(alarm.isOn ? 1 : 0.5)
                Spacer()
            }
            .contentShape(Rectangle())
            .layoutPriority(1)
            .onTapGesture(perform: onTapGesture)
            
            Toggle("", isOn: $alarm.isOn)
        }
    }
}

struct AlarmListCell_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListCell(alarm: .constant(Alarm()), onTapGesture: {})
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
