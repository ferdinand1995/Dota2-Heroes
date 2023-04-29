//
//  CoreNumeric.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import Foundation

extension Int {
    func milisToHour() -> Int {
        return (self / 3600000)
    }
    
    func milisToMinute() -> Int {
        return (self / 60000)
    }
    
    func hourToMilis() -> Int {
        return (self * 3600000)
    }
    
    var currencyFormat: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "-"
    }
}

extension Double {
    func milisToHour() -> Double {
        return (self / 3600000)
    }
    
    var cleanDecimal: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.2f", self) : String(format: "%.2f", self)
    }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var cleanDecimal: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
    
    func milisToHour() -> Float {
        return (self / 3600000)
    }
    
    func milisToMinute() -> Float {
        return (self / 60000)
    }
    
    func hourToMilis() -> Float {
        return (self * 3600000)
    }
    
    var currencyFormat: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "-"
    }
}
