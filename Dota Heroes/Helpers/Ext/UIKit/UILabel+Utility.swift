//
//  CoreUILabel.swift
//  Diabetic Educator iOS (iOS)
//
//  Created by DSS-Titus on 10/08/21.
//

import Foundation
import UIKit.UILabel

extension UILabel {
    func strikeThrough(text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
    }
}
