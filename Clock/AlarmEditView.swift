//
//  AlarmEditView.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import SwiftUI

struct AlarmEditView: View {
    @EnvironmentObject var alarmStore: AlarmStore
    @State private var alarm = Alarm()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Alarm time", selection: $alarm.time, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                NavigationLink(destination: RepeatEditView(whenRepeated: $alarm.whenRepeated)) {
                    HStack {
                        Text("Repeat")
                        Spacer()
                        Text("Never")
                            .foregroundColor(.secondary)
                    }
                }
                NavigationLink(destination: LabelEditView(label: $alarm.label)) {
                    HStack {
                        Text("Label")
                        Spacer()
                        Text(alarm.label)
                            .foregroundColor(.secondary)
                    }
                }
                NavigationLink(destination: Text("Maybe in the future ;)")) {
                    HStack {
                        Text("Sound")
                        Spacer()
                        Text("Alarm")
                            .foregroundColor(.secondary)
                    }
                }
                Toggle("Snooze", isOn: $alarm.isSnoozable)
            }
            .navigationTitle("Add Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.orange)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        alarmStore.addAlarm(alarm)
                        dismiss()
                    } label: {
                        Text("Save")
                            .foregroundColor(.orange)
                    }
                }
            }
        }
    }
}


struct AlarmEditView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmAdditionView()
            .preferredColorScheme(.dark)
    }
}
