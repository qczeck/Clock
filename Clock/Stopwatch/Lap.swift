//
//  Lap.swift
//  Clock
//
//  Created by Maciej Kuczek on 14/12/2021.
//

import Foundation

struct Lap: Codable, Identifiable {
    var id: Int
    var time: Double
    
    var isFastest = false
    var isSlowest = false
}
