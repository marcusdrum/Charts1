//
//  Enums.swift
//  ConsoMeter
//
//  Created by Mark on 12/11/2021.
//

import Foundation
//import GRDB

enum MeterType: String, Identifiable, CaseIterable, Codable {
    // ⚡️💧 ⛽️🔥🏠
    case elec = "⚡️ Elec"
    case elec2 = "⚡️ Elec2"
    case gas = "🔥 Gas"
    case water = "💧 Water"
    case tank = "⛽️ Tank"
    
    var id: String {self.rawValue}
}

//extension MeterType : DatabaseValueConvertible { }


enum Frequency: Int, Identifiable, CaseIterable, Codable {
    case month = 1, quarter = 3, semester = 6, year = 12
    
    var id: Int {self.rawValue}
}

//extension Frequency : DatabaseValueConvertible { }

enum ReadingType:String, Identifiable, CaseIterable, Codable {
    case annual = "Annual", intermediate = "Intermediate"
    
    var id: String {self.rawValue}
}

//extension ReadingType : DatabaseValueConvertible { }

enum ExportFormat: String, Identifiable, CaseIterable, Codable  {
    case csv = "CSV"
    case exchange = "Exchange"
    
    var id: String {self.rawValue}
}
