//
//  ChartByYearView.swift
//  Charts1
//
//  Created by Mark on 22/03/2023.
//

import SwiftUI
import Charts

struct ChartByYearView: View {
    //@State var rByMonth: [ReadingByMonth]
    var meter: Meter
    var years: [Int] = [2022, 2023]
    @State var unit: Calendar.Component = .month
    @State var meter2: Int64? = 0
    
    var body: some View {
        
        VStack {
            Picker("Date", selection: $unit.animation(.easeInOut)) {
                Text("Month").tag(Calendar.Component.month)
                Text("Year").tag(Calendar.Component.year)
            }
            .pickerStyle(.segmented)
            
            HStack {
                Picker("Meter", selection: $meter2) {
                    Text("No Option").tag(Optional<Int64>(0))
                    ForEach(meters, id: \.id) { meter in
                        Text("\(meter.name)").tag(Int(meter.id!))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                if let meterName = meter2 {
                    Text("add chart for \(meterName)")
                }
            }
        }
        .onChange(of: meter2) { meter2 in
            print("onchange called \(String(describing: meter2))")
            picked()
        }
        
        
        Chart {
            ForEach(years, id: \.self) { year in
                ForEach(rByMonth.filter({$0.date.year() == year}), id: \.id) { rByMonth in
                    BarMark (
                        // [.year, .month] plots all data over multi years and months
                        // [.month] groups diff years within same month
                        x: .value("Dates", rByMonth.date.dateFrom([.month]), unit: unit),
                        y: .value("Kw",rByMonth.consumed)
                    )
                    .position(by: .value("Month", rByMonth.date.year() ))
                    .foregroundStyle(by: .value("Meter", rByMonth.meterId ))
                    //.foregroundStyle(by: .value("Meter", year ))
                }
            }
        }
        .chartYAxisLabel("\(meter.unit)/\(unit)")
        //.chartForegroundStyleScale(domain: years)
        
        
        .task {
            //await meterVM.getMeterReadings(for: meter)
            getYears()
        }
    }
    
    private func getYears() {
        let years = Set(rByMonth.map {$0.date.year()})
//        for year in years {
//            self.years.append(year)
//        }
        print("chart years \(years)")
    }
    
    private func picked() {
        print("picked called \(String(describing: meter2))")
//        if let id1 = meter.id, let id2 = meter2 {
//            Task {
//                meterVM.getMeterReadings(for: [id1, id2])
//            }
//        }
    }
    
    let dateFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        return format
    }()


    let meters = [Meter.dummyMeter]

    let rByMonth = [
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
}

struct ChartByYearView_Previews: PreviewProvider {
    static var previews: some View {
        ChartByYearView(meter: Meter.dummyMeter)
    }
}
