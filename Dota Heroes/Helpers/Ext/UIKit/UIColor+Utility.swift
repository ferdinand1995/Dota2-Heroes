//
//  CoreUIColour.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit.UIColor

extension UIColor {

    class func hexStringToUIColor(_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString = String(cString.dropFirst()) }
        if ((cString.count) != 6) { return UIColor.gray }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    class var TEXTFIELD_BORDER_COLOR: UIColor {
        return self.hexStringToUIColor("#D9DFEB")
    }
    class var MAIN_ACTIVE_COLOR: UIColor {
        return self.hexStringToUIColor("#FFBA51")
    }
    /// Hex Color #FFBA51
    class var MAIN_IDLE_COLOR: UIColor {
        return self.hexStringToUIColor("#FFBA51")
    }
    /// Hex Color #A7A7C4
    class var MAIN_PLACEHOLDER_COLOR: UIColor {
        return self.hexStringToUIColor("#A7A7C4")
    }
    class var MAIN_GREEN_COLOR: UIColor {
        return self.hexStringToUIColor("#49A12C")
    }
    class var MAIN_RED_COLOR: UIColor {
        return self.hexStringToUIColor("#D0021B")
    }
    class var MAIN_YELLOW_COLOR: UIColor {
        return self.hexStringToUIColor("#FFBA51")
    }
    class var MAIN_BLACK_COLOR: UIColor {
        return self.hexStringToUIColor("#353957")
    }
    class var MAIN_BLUE_COLOR: UIColor {
        return self.hexStringToUIColor("#1A2268")
    }
    class var MAIN_GRAY_COLOR: UIColor {
        return self.hexStringToUIColor("#EBEBF1")
    }
    class var DARK_GRAY_COLOR: UIColor {
        return self.hexStringToUIColor("#6E6E6E")
    }

    class var CALENDAR_MAIN_COLOR: UIColor {
        return self.hexStringToUIColor("#191F6A")
    }
    class var CALENDAR_WEEK_COLOR: UIColor {
        return self.hexStringToUIColor("#8A8DA5")
    }

    class var LIGHT_GRAY_COLOR: UIColor {
        return self.hexStringToUIColor("BABABA")
    }
    class var GRAY_BLUE_COLOR: UIColor {
        return self.hexStringToUIColor("646782")
    }
    class var LIGHT_GREEN_COLOR: UIColor {
        return self.hexStringToUIColor("D4E7CE")
    }

    // MARK: Appointment
    class var APPOINTMENT_YELLOW_COLOR: UIColor {
        return self.hexStringToUIColor("#FFDE65")
    }
    class var APPOINTMENT_GREEN_COLOR: UIColor {
        return self.hexStringToUIColor("#A8DF95")
    }
    class var APPOINTMENT_RED_COLOR: UIColor {
        return self.hexStringToUIColor("#FFCCCC")
    }
    class var APPOINTMENT_GRAY_COLOR: UIColor {
        return self.hexStringToUIColor("#F6F6F9")
    }

    // MARK: Chart
    class var DIABISA_CHART_RED_COLOR: UIColor {
        return self.hexStringToUIColor("EC375A")
    }
    class var DIABISA_CHART_YELLOW_COLOR: UIColor {
        return self.hexStringToUIColor("FFBA51")
    }
    class var DIABISA_CHART_GREEN_COLOR: UIColor {
        return self.hexStringToUIColor("68B983")
    }
    class var DIABISA_CHART_BLUE_COLOR: UIColor {
        return self.hexStringToUIColor("77CEFF")
    }
    
    class var PRESCRIPTION_MISSED_RED_COLOR: UIColor {
        return self.hexStringToUIColor("D60000")
    }
}
