//
//  CoreUIButton.swift
//  Diabetic Educator iOS (iOS)
//
//  Created by DSS-Titus on 10/08/21.
//

import Foundation
import UIKit.UIButton

extension UIButton {
    
    /// for button with white background & border (text & border color is the same)
    func setRoundedButtonBordered(color: UIColor, text: String = "") {
        self.roundViewCorner(cornerRadius: self.frame.height/2, borderWidth: 1, borderColor: color)
        self.backgroundColor = .white
        self.setTitleColor(color, for: .normal)
        if text != "" { self.setTitle(text, for: .normal) }
    }
    
    /// for button with background color
    func setRoundedButtonColored(background: UIColor, textColor: UIColor = .clear, text: String = "") {
        self.roundViewCorner(cornerRadius: self.frame.height/2, borderWidth: 1, borderColor: background)
        self.backgroundColor = background
        if textColor != .clear { self.setTitleColor(textColor, for: .normal) }
        if text != "" { self.setTitle(text, for: .normal) }
    }
    
    func setGreenGradientButton(text: String) {
        self.setTitle(text, for: .normal)
        self.setGreenGradientBG()
        self.setTitleColor(.white, for: .normal)
    }
    
    func setGreenGradientBG() {
        self.circleIt()
        self.setTitleColor(.white, for: .normal)
        
        let gradient = CAGradientLayer()
        gradient.name = "gradientLayer"
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 48)
        gradient.colors = [UIColor(red: 0.3, green: 0.64, blue: 0.18, alpha: 1).cgColor, UIColor(red:0.2, green:0.57, blue:0.08, alpha:1).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.cornerRadius = 24
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGreenGradientForOtherViewBG(){
        let gradient = CAGradientLayer()
        gradient.name = "gradientLayer"
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 112, height: 48)
        gradient.colors = [UIColor(red: 0.3, green: 0.64, blue: 0.18, alpha: 1).cgColor, UIColor(red:0.2, green:0.57, blue:0.08, alpha:1).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.cornerRadius = 24
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func removeGradientLayer() {
        for layer in layer.sublayers! {
            if layer.name == "gradientLayer" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func underlined(text: String, color: UIColor){
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                  NSAttributedString.Key.foregroundColor : color] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: text, attributes: underlineAttribute)
        self.setAttributedTitle(underlineAttributedString, for: .normal)
    }
}
