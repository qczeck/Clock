//
//  AlarmStore.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import Foundation

class AlarmStore: ObservableObject {
    @Published var alarms = [Alarm]() {
        didSet {
            save()
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            self.alarms = try JSONDecoder().decode([Alarm].self, from: data)
        } catch {
            alarms = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(alarms)
            try data.write(to: savePath)
        } catch {
            print("Error saving")
        }
    }

    let savePath = FileManager.getDocumentsDirectory().appendingPathComponent("alarms")
    
    static func repeatLabel(_ repetitions: [Alarm.Repetition]) -> String {
        var repeatLabelString = ""
        
        if repetitions.isEmpty {
            repeatLabelString = "Never"
        } else if repetitions.count == 7 {
            repeatLabelString = "Every day"
        } else if repetitions.count == 1 {
            switch repetitions[0] {
            case .monday: repeatLabelString = "Every Monday"
            case .tuesday: repeatLabelString = "Every Tuesday"
            case .wednesday: repeatLabelString = "Every Wednesday"
            case .thursday: repeatLabelString = "Every Thursday"
            case .friday: repeatLabelString = "Every Friday"
            case .saturday: repeatLabelString = "Every Saturday"
            case .sunday: repeatLabelString = "Every Sunday"
            }
        } else if repetitions.count == 2 && repetitions.contains(.saturday) && repetitions.contains(.sunday) {
            repeatLabelString = "Weekends"
        } else if repetitions.count == 5 && !repetitions.contains(.saturday) && !repetitions.contains(.sunday) {
            repeatLabelString = "Weekdays"
        } else {
            if repetitions.contains(.monday) {
                repeatLabelString += "Mon "
            }
            if repetitions.contains(.tuesday) {
                repeatLabelString += "Tue "
            }
            if repetitions.contains(.wednesday) {
                repeatLabelString += "Wed "
            }
            if repetitions.contains(.thursday) {
                repeatLabelString += "Thu "
            }
            if repetitions.contains(.friday) {
                repeatLabelString += "Fri "
            }
            if repetitions.contains(.saturday) {
                repeatLabelString += "Sat "
            }
            if repetitions.contains(.sunday) {
                repeatLabelString += "Sun "
            }
        }
        
        return repeatLabelString
    }
    
    // MARK: - Intent(s)
    
    func addAlarm(_ newAlarm: Alarm) {
        alarms.append(newAlarm)
        self.sortAlarms()
    }
    
    func sortAlarms() {
        alarms.sort(by: {
            if Calendar.current.component(.hour, from: $0.time) < Calendar.current.component(.hour, from: $1.time) {
                return true
            } else if Calendar.current.component(.hour, from: $0.time) == Calendar.current.component(.hour, from: $1.time) {
                if Calendar.current.component(.minute, from: $0.time) < Calendar.current.component(.minute, from: $1.time) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        })
    }
    
    func deleteAlarms(at offsets: IndexSet) {
        alarms.remove(atOffsets: offsets)
    }
}
