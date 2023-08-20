//
//  Meter.swift
//  ConsoMeter
//
//  Created by Mark on 12/11/2021.
//

import Foundation
//import GRDB

struct Meter: Hashable, Identifiable {
    var id: Int64?
    var locationId: Int64
    var name: String
    var identifier: String
    var description: String
    var meterType: MeterType // enum: MeterType
    var tankSize: Int?
    var readingDate: Date // format yyyy/MM/dd
    var frequency: Frequency // enum: Frequency  months 1 3 12
    //var lastRead: Date?
    var unit: String {
        get {
            switch meterType {
            case .elec, .elec2:
                return "Kw/Hr"
            case .tank:
                return "%Tank"
            case .gas, .water:
                return "m3"
            }
        }
    }
    var unitShort: String {
        get {
            switch meterType {
            case .elec, .elec2:
                return "Kw"
            case .tank:
                return "%"
            case .gas, .water:
                return "m3"
            }
        }
    }
}

extension Meter {
    static let dummyMeter = Meter(id: 2, locationId: 1, name: "Main", identifier: "EAN0123456789", description: "All of house water", meterType: MeterType.water, readingDate: Date(), frequency: Frequency.year)
    
    static func new(_ locationId: Int64, _ name: String, _ identifier: String, _ description: String, _ meterType: MeterType, _ tankSize: Int? ,_ readingDate: Date, _ frequency: Frequency) -> Meter
    {
        Meter(id: nil, locationId: locationId, name: name, identifier: identifier,
              description: description, meterType: meterType, tankSize: tankSize,
              readingDate: readingDate, frequency: frequency)
    }
    
    static let meter1 = Meter(id: nil, locationId: 1, name: "Main water", identifier: "EAN", description: "All house water", meterType: MeterType.water, readingDate: Date(), frequency: Frequency.year)
    static let meter2 = Meter(id: nil, locationId: 1, name: "Day Electricity", identifier: "EAN", description: "from 06:00 to 22:30", meterType: MeterType.elec, readingDate: Date(), frequency: Frequency.quarter)
    static let meter3 = Meter(id: nil, locationId: 1, name: "Night Electricity", identifier: "EAN", description: "from 22:30 to 06:00", meterType: MeterType.elec2, readingDate: Date(), frequency: Frequency.quarter)
    static let meter4 = Meter(id: nil, locationId: 1, name: "Central heating", identifier: "", description: "", meterType: MeterType.tank, tankSize: 2700, readingDate: Date(), frequency: Frequency.month)
    static let meter5 = Meter(id: nil, locationId: 1, name: "Hot water", identifier: "", description: "", meterType: MeterType.gas, readingDate: Date(), frequency: Frequency.quarter)
    
    static let startMeters = [meter1, meter2, meter3, meter4, meter5]
}

//extension Meter: Codable, FetchableRecord, MutablePersistableRecord {
//    // Define database columns from CodingKeys
//    fileprivate enum Columns {
//        static let locationId = Column(CodingKeys.locationId)
//        static let name = Column(CodingKeys.name)
//        static let description = Column(CodingKeys.description)
//        static let meterType = Column(CodingKeys.meterType)
//        //static let readingType = Column(CodingKeys.readingType)
//        static let readingDate = Column(CodingKeys.readingDate)
//        static let frequency = Column(CodingKeys.frequency)
//    }
//    
//    /// Updates  id after row has been inserted in the database.
//    mutating func didInsert(with rowID: Int64, for column: String?) {
//        id = rowID
//    }
//}
