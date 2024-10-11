//
//  UtilityExtensions.swift
//  Clock
//
//  Created by Maciej Kuczek on 12/12/2021.
//

import Foundation

extension Array where Element: Equatable {
    mutating func toggle(_ element: Element) {
        if self.contains(element) {
            if let index = self.firstIndex(where: { $0 == element }) {
                self.remove(at: index)
            }
        } else {
            self.append(element)
        }
    }
    
    func indexMatching(_ element: Element) -> Int? {
        if let index = self.firstIndex(where: { $0 == element }) {
            return index
        }
        
        return nil
    }
}

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


