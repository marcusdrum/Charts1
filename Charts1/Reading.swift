//
//  Reading.swift
//  ConsoMeter
//
//  Created by Mark on 12/11/2021.
//

import Foundation
//import GRDB

struct Reading: Hashable, Identifiable {
    var id: Int64?
    var meterId: Int64
    var date: Date // format yyyy/MM/dd
    var value: Double
    var readingType: ReadingType
    var comment: String
    var consumed: Double // value consumed per day between start and end dates
    var days: Int
    var startDate: Date {
        get {
            return self.date.adding(.day, value: (self.days * -1 ))
        }
    }
    
    init(id: Int64? = nil, meterId: Int64, date: Date, value: Double, readingType: ReadingType, comment: String, consumed: Double, days: Int) {
        self.id = id
        self.meterId = meterId
        self.date = date
        self.value = value
        self.readingType = readingType
        self.comment = comment
        self.consumed = consumed
        self.days = days
//        self.startDate = self.date.subtractUntilStartOfYear(.day, value: self.days)
    }
}

extension Reading {
    static let dummyReading = Reading(id: 1, meterId: 1, date: Date(), value: 115.234, readingType: .annual, comment: "", consumed: 124.0, days: 65)
    
    static func new(meterId: Int64, date: Date, value: Double, readingType: ReadingType, comment: String, consumed: Double, days: Int) -> Reading {
        Reading(id: nil, meterId: meterId, date: date, value: value, readingType: readingType, comment: comment, consumed: consumed, days: days)
    }
}

//extension Reading: Codable, FetchableRecord, MutablePersistableRecord {
//    // Define database columns from CodingKeys
//    fileprivate enum Columns {
//        static let meterId = Column(CodingKeys.meterId)
//        static let date = Column(CodingKeys.date)
//        static let value = Column(CodingKeys.value)
//        static let readingType = Column(CodingKeys.readingType)
//        static let comment = Column(CodingKeys.comment)
//        static let consumed = Column(CodingKeys.consumed)
//        static let days = Column(CodingKeys.days)
//    }
//    
//    /// Updates  id after row has been inserted in the database.
//    mutating func didInsert(with rowID: Int64, for column: String?) {
//        id = rowID
//    }
//}

// for sorting [Reading] in place
// usage: readings.sort(by: Reading.Compare.asc)
extension Reading {
    enum Sort {
        static let asc: (Reading, Reading) -> Bool = {
            return ($0.meterId, $0.date) < ($1.meterId, $1.date)
        }
        
        static let desc: (Reading, Reading) -> Bool = {
            return ($0.meterId, $0.date) > ($1.meterId, $1.date)
        }
    }
}
