//
//  AlarmView.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import SwiftUI

struct AlarmView: View {
    @EnvironmentObject var alarmStore: AlarmStore
    
    @State private var showingSheet = false
    @State private var showingAddSheet = false
    @State private var showingEditSheet = false
    
    @State private var alarmToEdit: Alarm?
    
    @State private var sheetType = SheetType.addingAlarm
    
    var body: some View {
        NavigationView {
            List {
                ForEach($alarmStore.alarms) { $alarm in
                    AlarmListCell(alarm: $alarm) {
                        sheetType = .editingAlarm(alarmStore.alarms.indexMatching(alarm) ?? 0)
                        showingSheet = true
                    }
                }
                .onDelete { offsets in
                    alarmStore.deleteAlarms(at: offsets)
                }
            }
                .sheet(isPresented: $showingSheet) {
                    SheetView(type: $sheetType)
                }
                .listStyle(.plain)
                .navigationTitle("Alarm")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .foregroundColor(.orange)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheetType = .addingAlarm
                            showingSheet = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.orange)
                        }
                        .sheet(isPresented: $showingSheet) {
                            SheetView(type: $sheetType)
                        }
                    }
                }
//                .sheet(isPresented: $showingSheet) {
//                    SsheetView(type: $sheetType)
//                }
        }
    }
}

enum SheetType {
    case addingAlarm
    case editingAlarm(Int)
}

struct SheetView: View {
    @EnvironmentObject var alarmStore: AlarmStore
    @Binding var type: SheetType
    
    var body: some View {
        switch type {
        case .addingAlarm:
            AlarmAdditionView()
        case .editingAlarm(let index):
            AlarmEditView(alarm: $alarmStore.alarms[index])
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
            .preferredColorScheme(.dark)
            .environmentObject(AlarmStore())
    }
}
