//
//  ExtensionDate.swift
//  Conso-Meter (iOS)
//
//  Created by Mark on 16/03/2023.
//

import Foundation

extension Date {
    
    func dawn(using calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    func noon(using calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func day(using calendar: Calendar = .current) -> Int {
        calendar.component(.day, from: self)
    }
    
    func month(using calendar: Calendar = .current) -> Int {
        calendar.component(.month, from: self)
    }
    
    func dateFrom(_ components: Set<Calendar.Component>, using calendar: Calendar = .current) -> Date {
        return calendar.date(from: calendar.dateComponents(components, from: self)) ?? Date()
    }
    
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        //print("end \(self) adding \(value) start \(calendar.date(byAdding: component, value: value, to: self)!)")
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    
    func addingUntilEndOfYear(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        let oldDate = self
        //print("start:\(self) value:\(value) oldYear:\(oldDate)")
        let newDate = calendar.date(byAdding: component, value: value, to: self)!
        //print("newDate:\(newDate)")
        if newDate.year() > oldDate.year() {
            //print("return end of year:\(oldDate.endOfYear())\n")
            return oldDate.endOfYear()
        } else {
            //print("return newdate \(newDate)\n")
            return newDate
        }
    }
    
    func subtractUntilStartOfYear(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        let oldDate = self
        //print("start:\(self) value:\(value) oldYear:\(oldDate)")
        let newDate = calendar.date(byAdding: component, value: (value * -1), to: self)!
        //print("newDate:\(newDate)")
        if newDate.year() < oldDate.year() {
            //print("return start of year:\(oldDate.startOfYear())\n")
            return oldDate.startOfYear()
        } else {
            //print("return newdate \(newDate)\n")
            return newDate
        }
    }
    
    func monthSymbol(using calendar: Calendar = .current) -> String {
        calendar.monthSymbols[calendar.component(.month, from: self)-1]
    }
    
    func shortMonthSymbol(using calendar: Calendar = .current) -> String {
        calendar.shortMonthSymbols[calendar.component(.month, from: self)-1]
    }
    
    func year(using calendar: Calendar = .current) -> Int {
        calendar.component(.year, from: self)
    }
    
    func yearString(using calendar: Calendar = .current) -> String {
        String(calendar.component(.year, from: self))
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func startOfYear() -> Date {
        var comps = DateComponents()
        comps.day = 1
        comps.month = 1
        comps.year = self.year()
        return Calendar.current.date(from: comps)!
    }
    
    func endOfYear() -> Date {
        var comps = DateComponents()
        comps.day = 31
        comps.month = 12
        comps.year = self.year()
        return Calendar.current.date(from: comps)!
    }
}
