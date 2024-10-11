//
//  AlarmAdditionView.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import SwiftUI

struct AlarmAdditionView: View {
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
                        Text(AlarmStore.repeatLabel(alarm.whenRepeated))
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

struct AlarmEditView: View {
    @EnvironmentObject var alarmStore: AlarmStore
    @Binding var alarm: Alarm
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Alarm time", selection: $alarm.time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                    NavigationLink(destination: RepeatEditView(whenRepeated: $alarm.whenRepeated)) {
                        HStack {
                            Text("Repeat")
                            Spacer()
                            Text(AlarmStore.repeatLabel(alarm.whenRepeated))
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
                
                Section {
                    Button(role: .destructive) {
                        dismiss()
                        alarmStore.alarms.removeAll(where: { alarm.id == $0.id} )
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Alarm")
                            Spacer()
                        }
                    }
                    .disabled(alarmStore.alarms.indexMatching(alarm) == alarmStore.alarms.count - 1)
                }
            }
            .navigationTitle("Edit Alarm")
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
                        if let index = alarmStore.alarms.indexMatching(alarm) {
                            alarmStore.alarms[index] = alarm
                        }
                        alarmStore.sortAlarms()
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

struct RepeatEditView: View {
    @Binding var whenRepeated: [Alarm.Repetition]
    
    var body: some View {
        Form {
            Button {
                whenRepeated.toggle(.monday)
            } label: {
                HStack {
                    Text("Every Monday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.monday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Button {
                whenRepeated.toggle(.tuesday)
            } label: {
                HStack {
                    Text("Every Tuesday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.tuesday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Button {
                whenRepeated.toggle(.wednesday)
            } label: {
                HStack {
                    Text("Every Wednesday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.wednesday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Button {
                whenRepeated.toggle(.thursday)
            } label: {
                HStack {
                    Text("Every Thursday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.thursday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Button {
                whenRepeated.toggle(.friday)
            } label: {
                HStack {
                    Text("Every Friday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.friday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Button {
                whenRepeated.toggle(.saturday)
            } label: {
                HStack {
                    Text("Every Saturday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.saturday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Button {
                whenRepeated.toggle(.sunday)
            } label: {
                HStack {
                    Text("Every Sunday")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.orange)
                        .opacity(whenRepeated.contains(.sunday) ? 1 : 0)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}


struct LabelEditView: View {
    @Binding var label: String
    
    var body: some View {
        TextField("", text: $label)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct AlarmAdditionView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmAdditionView()
            .preferredColorScheme(.dark)
    }
}

struct AlarmEditView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmEditView(alarm: .constant(Alarm()))
            .preferredColorScheme(.dark)
    }
}
