//
//  WorldClockStore.swift
//  Clock
//
//  Created by Maciej Kuczek on 20/12/2021.
//

import Foundation

class WorldClockStore: ObservableObject {
    @Published var timeZoneIdentifiers: [String] {
        didSet {
            save()
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            self.timeZoneIdentifiers = try JSONDecoder().decode([String].self, from: data)
        } catch {
            timeZoneIdentifiers = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(timeZoneIdentifiers)
            try data.write(to: savePath)
        } catch {
            print("Error saving")
        }
    }

    let savePath = FileManager.getDocumentsDirectory().appendingPathComponent("worldClocks")
    
    func delete(at offsets: IndexSet) {
        timeZoneIdentifiers.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        timeZoneIdentifiers.move(fromOffsets: source, toOffset: destination)
    }
    
    func add(_ timeZoneIdentifier: String) {
        if TimeZone.knownTimeZoneIdentifiers.contains(timeZoneIdentifier) {
            timeZoneIdentifiers.append(timeZoneIdentifier)
        }
    }
    
    static func timeIn(_ identifier: String) -> String {
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        if let timeZone = TimeZone(identifier: identifier) {
            timeFormat.timeZone = timeZone
        } else {
            timeFormat.timeZone = TimeZone(secondsFromGMT: 0)
        }
        return timeFormat.string(from: Date())
    }
    
    static func displayableTimeZoneIdentifier(_ timeZoneIdentifier: String) -> String {
//        let prefixes = ["America/", "Antarctica/", "Arctic/", "Asia/", "Atlantic/", "Australia/", "Europe/", "Indian/", "Pacific/", "Africa/", "Argentina/"]
//
//        for prefix in prefixes {
//            if timeZoneIdentifier.hasPrefix(prefix) {
//                return String(timeZoneIdentifier.dropFirst(prefix.count))
//            }
//        }
        
        var numberOfCharactersToDrop = 0
        var identifier = timeZoneIdentifier
        
        for ch in timeZoneIdentifier.reversed() {
            if ch == "/" {
                identifier = String(timeZoneIdentifier.dropFirst(timeZoneIdentifier.count - numberOfCharactersToDrop))
                break
            } else {
                numberOfCharactersToDrop += 1
            }
        }
        
        return identifier.replacingOccurrences(of: "_", with: " ")
    }
    
    static func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func timeDifference(_ timeZoneIdentifier: String) -> String? {
        if let timeZone = TimeZone(identifier: timeZoneIdentifier) {
            let secondsDifference = timeZone.secondsFromGMT() - Calendar.current.timeZone.secondsFromGMT()
//            let hours = (secondsDifference / 3600)
            
            let time = secondsToHoursMinutesSeconds(secondsDifference)
            
            if time.1 == 0 {
                switch time.0 {
                case Int.min...(-1):
                    return "\(time.0)HRS"
                case 1:
                    return "+\(time.0)HR"
                case -1:
                    return "\(time.0)HR"
                default:
                    return "+\(time.0)HRS"
                }
            } else {
                if secondsDifference >= 0 {
                    return "+\(time.0):\(time.1)"
                } else {
                    return "\(time.0):\(time.1)"
                }
            }
            
//            if hours.truncatingRemainder(dividingBy: 3600) != 0 {
//                if hours < -1 {
//                    return "\(hours)HRS"
//                } else if hours == -1 {
//                    return "\(hours)HR"
//                } else if hours == 1 {
//                    return "+\(hours)HR"
//                } else {
//                    return "+\(hours)"
//                }
//            } else {
//                return "\(hours.rounded(.down)):\(hours.truncatingRemainder(dividingBy: 3600)/60)"
//            }
            
//            switch hours {
//            case Int.min...(-1):
//                return "\(hours)HRS"
//            case 1:
//                return "+\(hours)HR"
//            case -1:
//                return "\(hours)HR"
//            default:
//                return "+\(hours)HRS"
//            }

        } else {
            return nil
        }
    }
}
