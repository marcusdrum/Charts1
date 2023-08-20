//
//  PreviewData.swift
//  ConsoMeter (iOS)
//
//  Created by Mark on 03/12/2021.
//

import Foundation

class PreviewData: ObservableObject {
    
    @Published var locations: [Location] = []

    @Published var meters: [Meter] = []

    @Published var readings: [Reading] = []
    
    @Published var rByMonth: [ReadingByMonth] = []

    @Published var schedule: [String:[Meter]] = [:]

    @Published var selectedLocationId: Int64? = nil

    var showAlert: Bool = false
    var alertTitle = ""
    var alertMessage = ""
    var progress: Double = 0.0
    
    let today = Date()
    
    let dayFmt: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .ordinal
            numberFormatter.locale = Locale.current
            return numberFormatter
        }()
    
    
    let dateFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        return format
    }()
    
    init() {
        print("PreviewData init")
        
        let loc1 = Location(id: 1, name: "Paris", description: "city")
        let loc2 = Location(id: 2, name: "London", description: "town")
        let loc3 = Location(id: 3, name: "New York", description: "china town")
        let loc4 = Location(id: 4, name: "Milan", description: "center")

        locations = [loc1, loc2, loc3, loc4]
            
        let meter1 = Meter(id: 1, locationId: 1, name: "Main water", identifier: "EAN0123456789", description: "All house water", meterType: MeterType.water, readingDate: dateFormat.date(from: "2020/11/15")!, frequency: Frequency.year)
        let meter2 = Meter(id: 2, locationId: 1, name: "Day Electricity", identifier: "EAN0123456789", description: "", meterType: MeterType.elec, readingDate: dateFormat.date(from: "2020/03/01")!, frequency: Frequency.quarter)
        let meter3 = Meter(id: 3, locationId: 1, name: "Night Electricity", identifier: "EAN0123456789", description: "from 22:30 to 06:00", meterType: MeterType.elec2, readingDate: dateFormat.date(from: "2020/01/15")!, frequency: Frequency.quarter)
        let meter4 = Meter(id: 4, locationId: 1, name: "Central heating", identifier: "EAN0123456789", description: "", meterType: MeterType.tank, tankSize: 2700, readingDate: dateFormat.date(from: "2020/01/15")!, frequency: Frequency.year)
        let meter5 = Meter(id: 5, locationId: 1, name: "Hot water", identifier: "EAN0123456789", description: "", meterType: MeterType.gas, readingDate: dateFormat.date(from: "2020/07/14")!, frequency: Frequency.month)
        
  
        meters = [meter1, meter2, meter3, meter4, meter5]
        
//        locMeters = []
//        for loc in locations {
//            var locMeter = LocMeter(id: loc.id, name: "🏠 \(loc.name)", type: 1, children: [])
//            var children: [LocMeter] = []
//            for meter in meters {
//                let meterCh = LocMeter(id: meter.id, name: "\(meter.meterType.rawValue) \(meter.name)", type: 2)
//                children.append(meterCh)
//            }
//            if !children.isEmpty {
//                locMeter.children = children
//            }
//            locMeters.append(locMeter)
//        }
        
        readings = [
            // water
            Reading(id: 1, meterId: 1, date: dateFormat.date(from: "2018/01/15")!, value: 115.234, readingType: .annual, comment: "", consumed: 0.0, days: 0),
            Reading(id: 2, meterId: 1, date: dateFormat.date(from: "2019/01/15")!, value: 137.234, readingType: .annual, comment: "", consumed: 22.0, days: 365),
            Reading(id: 3, meterId: 1, date: dateFormat.date(from: "2020/01/15")!, value: 225.234, readingType: .annual, comment: "", consumed: 88.0, days: 365),
            // elec 1
            Reading(id: 4, meterId: 2, date: dateFormat.date(from: "2019/07/04")!, value: 1115.23, readingType: .annual, comment: "", consumed: 0.0, days: 0),
            Reading(id: 5, meterId: 2, date: dateFormat.date(from: "2020/07/03")!, value: 2515.23, readingType: .annual, comment: "", consumed: 1400.0, days: 365),
            Reading(id: 6, meterId: 2, date: dateFormat.date(from: "2021/07/02")!, value: 3720.23, readingType: .annual, comment: "", consumed: 1305.0, days: 365),
            // elec 2
            Reading(id: 7, meterId: 3, date: dateFormat.date(from: "2019/07/04")!, value: 655.23, readingType: .annual, comment: "", consumed: 0.0, days: 0),
            Reading(id: 8, meterId: 3, date: dateFormat.date(from: "2020/07/03")!, value: 1815.23, readingType: .annual, comment: "", consumed: 1160.0, days: 365),
            Reading(id: 9, meterId: 3, date: dateFormat.date(from: "2021/07/02")!, value: 3220.23, readingType: .annual, comment: "", consumed: 1405.0, days: 365),
            // tank is percentage of tank of 2700liters
            Reading(id: 10, meterId: 4, date: dateFormat.date(from: "2021/01/02")!, value: 100.00, readingType: .annual, comment: "Tank filled", consumed: 0.0, days: 0),
            Reading(id: 11, meterId: 4, date: dateFormat.date(from: "2021/02/03")!, value: 91.00, readingType: .intermediate, comment: "", consumed: 9.0, days: 31),
            Reading(id: 12, meterId: 4, date: dateFormat.date(from: "2021/03/01")!, value: 82.00, readingType: .intermediate, comment: "", consumed: 9.0, days: 28),
            Reading(id: 13, meterId: 4, date: dateFormat.date(from: "2021/04/02")!, value: 74.00, readingType: .intermediate, comment: "", consumed: 8.0, days: 30),
            Reading(id: 14, meterId: 4, date: dateFormat.date(from: "2020/05/03")!, value: 66.00, readingType: .intermediate, comment: "Heating stopped", consumed: 8.0, days: 30),
            Reading(id: 15, meterId: 4, date: dateFormat.date(from: "2021/06/01")!, value: 59.00, readingType: .intermediate, comment: "", consumed: 7.0, days: 31),
            // gas
            Reading(id: 16, meterId: 5, date: dateFormat.date(from: "2020/02/03")!, value: 2591.150, readingType: .intermediate, comment: "", consumed: 0.0, days: 0),
            Reading(id: 17, meterId: 5, date: dateFormat.date(from: "2020/03/04")!, value: 2700.250, readingType: .intermediate, comment: "", consumed: 109.150, days: 31)
        ]

        let strategy = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)T\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits):\(second: .twoDigits)\(timeZone: .iso8601(.short))", timeZone: .current)
        // usage let date = try? Date("2016-04-14T10:44:00+0000", strategy: strategy)
        
    rByMonth = [
//        ReadingByMonth(date: try! Date("2022-01-30 23:00:00 +0000", strategy: strategy), consumed: 116.12, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-01-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 116.12, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-02-27 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 109.27, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-03-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 120.98, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-04-29 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 117.08, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-05-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 107.61, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-06-29 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 97.11, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-07-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 104.90, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-08-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 104.90, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-09-29 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 97.59, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-10-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 122.82, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-11-29 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 118.67, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-12-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 164.23, meterId: 2 ),
        ReadingByMonth(date: try! Date("2023-01-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 115.42, meterId: 2 ),
        ReadingByMonth(date: try! Date("2023-02-27 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 106.74, meterId: 2 ),
        ReadingByMonth(date: try! Date("2023-03-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 57.68, meterId: 2 ),
        ReadingByMonth(date: try! Date("2022-01-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 112.80, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-02-27 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 114.48, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-03-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 126.74, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-04-29 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 122.65, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-05-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 121.93, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-06-29 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 117.12, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-07-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 124.31, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-08-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 124.31, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-09-29 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 112.62, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-10-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 120.01, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-11-29 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 139.85, meterId: 3 ),
        ReadingByMonth(date: try! Date("2022-12-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 174.67, meterId: 3 ),
        ReadingByMonth(date: try! Date("2023-01-30 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 128.53, meterId: 3 ),
        ReadingByMonth(date: try! Date("2023-02-27 23:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 103.81, meterId: 3 ),
        ReadingByMonth(date: try! Date("2023-03-30 22:00:00 +0000", strategy: ReadingByMonth.strategy), consumed: 59.00, meterId: 3 )
        ]
        
        print("preview data rByMonth \(rByMonth)")
    }
    
    func getLocations() -> [Location] {
        return locations
    }
    
    func getMeters() -> [Meter] {
        return meters
    }
    
    func getReadings() -> [Reading] {
        return readings
    }
    
    func getMeterReadings(for meter: Meter) async {
        print("preview data")
    }
    
    func getMeterReadings(for meterIds: Set<Int64>) {
        print("preview data")
    }
    
    func getReadingsByMonth() -> [ReadingByMonth] {
        return rByMonth
    }
}
