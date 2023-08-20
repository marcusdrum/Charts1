//
//  ReadingByYear.swift
//  Conso-Meter (iOS)
//
//  Created by Mark on 16/03/2023.
//

import Foundation

struct ReadingByYear: Identifiable {
    let year: Int
    var readings: [Reading]
    var id: Int { year }
}

struct ReadingByMonth: Identifiable {
    let date: Date
    var consumed: Double
    var meterId: Int64
    var id: Date { date }
    
    
    static let strategy = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)T\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits):\(second: .twoDigits)\(timeZone: .iso8601(.short))", timeZone: .current)
}

extension ReadingByMonth {
    enum Sort {
        static let asc: (ReadingByMonth, ReadingByMonth) -> Bool = {
            return ($0.meterId, $0.date) < ($1.meterId, $1.date)
        }
        
        static let desc: (ReadingByMonth, ReadingByMonth) -> Bool = {
            return ($0.meterId, $0.date) > ($1.meterId, $1.date)
        }
    }
    
}
