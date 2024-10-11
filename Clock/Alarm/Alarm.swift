//
//  Alarm.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import Foundation

struct Alarm: Codable, Identifiable, Equatable {
    var id: UUID
    var time = Date()
    var label = "Alarm"
    var whenRepeated = [Repetition]()
    var isSnoozable = true
    var isOn = true
    
    enum Repetition: Codable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
    }
    
    init() {
        self.id = UUID()
    }
    
    init(test: Repetition) {
        self.id = UUID()
        self.whenRepeated = [test]
    }
}
