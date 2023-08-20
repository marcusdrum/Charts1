//
//  Charts1App.swift
//  Charts1
//
//  Created by Mark on 21/03/2023.
//

import SwiftUI

@main
struct Charts1App: App {
    //var meterVM = PreviewData()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            ChartByMonthView(meter: Meter.dummyMeter)
                //.environmentObject(meterVM)
        }
    }
}
