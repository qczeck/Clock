//
//  TimerManager.swift
//  Clock
//
//  Created by Maciej Kuczek on 17/12/2021.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    var pickerData = [
        Array(0...23).map({ "\($0)h" }),
        Array(0...59).map({ "\($0)m" }),
        Array(0...59).map({ "\($0)s" }),
    ]
    
    @Published var time = [0,0,0]
    
    var startTime: [Int]?
    var startDate: Date?
    
    var endDate: String? {
        if let startDate = startDate, let startTime = startTime {
            let calendar = Calendar.current
            let endDate = startDate.addingTimeInterval(Double(convertToSeconds(startTime)))
            return String(format: "%02d:%02d", calendar.component(.hour, from: endDate), calendar.component(.minute, from: endDate))
        } else {
            return nil
        }
    }
    
    init() {
        
    }
    
    var timer: Timer?
    
    func convertToSeconds(_ timeArray: [Int]) -> Int {
        var s = 0
        s += timeArray[0]*3600 //hours
        s += timeArray[1]*60 //minutes
        s += timeArray[2] //seconds
        return s
    }
    
    var degrees: Double? {
        if let startTime = startTime {
            if convertToSeconds(time) == 0 {
                return 0
            } else {
                return 360*(Double(convertToSeconds(time)))/(Double(convertToSeconds(startTime))) - 0.01
            }
        } else {
            return nil
        }
    }
    
    func displayTime() -> String {
        if time[0] == 0 {
            return String(format: "%02d:%02d", time[1], time[2])
        } else {
            return String(format: "%02d:%02d:%02d", time[0], time[1], time[2])
        }
    }
    
    func start() {
        withAnimation {
            hasStarted = true
        }
        startTime = time
        startDate = Date()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            RunLoop.main.add(timer, forMode: .common)
            withAnimation(Animation.linear(duration: 1)) {
                self.update()
            }
        }
    }
    
    @Published var hasStarted = false
    
    func cancel() {
        isPaused = false
        withAnimation {
            hasStarted = false
        }
        if let startTime = startTime {
            time = startTime
        }
        timer?.invalidate()
    }
    
    func pause() {
        isPaused = true
        timer?.invalidate()
    }
    
    @Published var isPaused = false
    
    func resume() {
        isPaused = false
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            RunLoop.main.add(timer, forMode: .common)
            withAnimation(Animation.linear(duration: 1)) {
                self.update()
            }
        }
    }
    
    func update() {
        if time[2] >= 1 {
            time[2] -= 1
        } else if time[1] >= 1 {
            time[1] -= 1
            time[2] = 59
        } else if time[0] >= 1 {
            time[0] -= 1
            time[1] = 59
            time[2] = 59
        } else {
            timer?.invalidate()
        }
    }
    
}
