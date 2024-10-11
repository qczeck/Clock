//
//  StopwatchManager.swift
//  Clock
//
//  Created by Maciej Kuczek on 14/12/2021.
//

import Foundation

struct DrawingConstants {
    static var buttonSize: Double = 85
    static var buttonOpacity: Double = 0.2
}

class StopwatchManager: ObservableObject {
    @Published var laps = [Lap]()
    @Published var timeStarted = Date()
    
    @Published var seconds = 0.00

    init() {
        
    }
    
    func elapsedTime(seconds: Double) -> String {
        let hours = Int((seconds / 3600).rounded(.down))
        let minutes = Int(((seconds.truncatingRemainder(dividingBy: 3600))/60).rounded(.down))
        let displayedSeconds = seconds.truncatingRemainder(dividingBy: 60)
        
        
        if hours == 0 {
            return String(format: "%02d:%05.2f", minutes, displayedSeconds)
        } else {
            return String(format: "%02d:%02d:%05.2f", hours, minutes, displayedSeconds)
        }
    }
    
    var timer: Timer?
    
    var timerIsActive: Bool {
        if timer == nil {
            return false
        } else if !timer!.isValid {
            return false
        } else {
            return true
        }
    }
    
    func start() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            RunLoop.main.add(timer, forMode: .common)
            self.update()
        }
    }
    
    func update() {
        seconds += 0.01
    }
    
    func pause() {
        if let timer = timer {
            timer.invalidate()
        }
        objectWillChange.send()
    }
    
    func reset() {
        seconds = 0.00
        laps = []
        fastestLapIndex = 0
        slowestLapIndex = 0
        lastTimeLapWasPressed = 0.00
    }
    
    var lastTimeLapWasPressed: Double = 0.00
    var fastestLapIndex = 0
    var slowestLapIndex = 0
    
    func lap() {
        let time = seconds - lastTimeLapWasPressed
        var newLap = Lap(id: laps.count + 1, time: time)
        lastTimeLapWasPressed = seconds
        
        if laps.count == 0 {
            newLap.isFastest = true
            newLap.isSlowest = true
        } else {
            if newLap.time < laps[fastestLapIndex].time {
                newLap.isFastest = true
                laps[fastestLapIndex].isFastest = false
                fastestLapIndex = laps.count
            }
            
            if newLap.time > laps[slowestLapIndex].time {
                newLap.isSlowest = true
                laps[slowestLapIndex].isSlowest = false
                slowestLapIndex = laps.count
            }
        }
        
        laps.append(newLap)
    }
}
