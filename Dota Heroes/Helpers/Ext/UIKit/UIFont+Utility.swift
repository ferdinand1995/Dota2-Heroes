//
//  CoreUIFont.swift
//  Diabetic Educator iOS (iOS)
//
//  Created by DSS-Titus on 10/08/21.
//

import UIKit.UIFont

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    class func appSemiBoldFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: "Nunito-SemiBold", size: size)!
    }
    class func appBoldFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Bold", size: size)!
    }
    class func appRegularFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Regular", size: size)!
    }
    class func appItalicFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Italic", size: size)!
    }
}
