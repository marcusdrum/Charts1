//
//  Location.swift
//  ConsoMeter
//
//  Created by Mark on 12/11/2021.
//

import Foundation
//import GRDB

struct Location: Hashable {
    var id: Int64?
    var name: String
    var description: String
}

let defaultLocation = Location(id: 0, name: "Home", description: "Mi Casa")

extension Location {
    static let locationNames = ["Home", "Jupiter", "Genval"]
    static let dummyLocation = Location(id: 1, name: "Odri 44", description: "Odrimont")
    
    static func new(name: String, description: String) -> Location {
        Location(id: nil, name: name, description: description)
    }
}

//extension Location: Codable, FetchableRecord, MutablePersistableRecord {
//    // Define database columns from CodingKeys
//    fileprivate enum Columns {
//        static let name = Column(CodingKeys.name)
//        static let description = Column(CodingKeys.description)
//    }
//    
//    /// Updates  id after row has been inserted in the database.
//    mutating func didInsert(with rowID: Int64, for column: String?) {
//        id = rowID
//    }
//}
