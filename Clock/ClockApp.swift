//
//  ClockApp.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import SwiftUI

@main
struct ClockApp: App {
    
    @StateObject var worldClockStore = WorldClockStore()
    @StateObject var alarmStore = AlarmStore()
    @StateObject var stopwatchManager = StopwatchManager()
    @StateObject var timerManager = TimerManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                WorldClockView()
                    .environmentObject(worldClockStore)
                    .tabItem {
                        Image(systemName: "globe")
                        Text("World Clock")
                    }
                AlarmView()
                    .environmentObject(alarmStore)
                    .tabItem {
                        Image(systemName: "alarm.fill")
                        Text("Alarm")
                    }
                StopwatchView()
                    .environmentObject(stopwatchManager)
                    .tabItem {
                        Image(systemName: "stopwatch.fill")
                        Text("Stopwatch")
                    }
                TimerView()
                    .environmentObject(timerManager)
                    .tabItem {
                        Image(systemName: "timer")
                        Text("Timer")
                    }
            }
        }
    }
}
