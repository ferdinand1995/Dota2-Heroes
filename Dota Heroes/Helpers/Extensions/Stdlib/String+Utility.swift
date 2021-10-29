//
//  CoreString.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import Foundation

extension String {
    func neutralTimeZone() -> String {
        let newText = self + "T00:00:00.000Z"
        return newText
    }

    func urlencoding() -> String {
        var output: String = ""
        
        for thisChar in self {
            if thisChar == " " {
                output += "+"
            }
            else if thisChar == "." ||
                thisChar == "-" ||
                thisChar == "_" ||
                thisChar == "~" ||
                (thisChar >= "a" && thisChar <= "z") ||
                (thisChar >= "A" && thisChar <= "Z") ||
                (thisChar >= "0" && thisChar <= "9") {
                let code = String(thisChar).utf8.map{ UInt8($0) }[0]
                output += String(format: "%c", code)
            }
            else {
                let code = String(thisChar).utf8.map{ UInt8($0) }[0]
                output += String(format: "%%%02X", code)
            }
        }
        
        return output;
    }
    
    var isNumeric : Bool {
        if self == "" {
            return true
        }
        return Double(self) != nil
    }
    
    ///SETUP: Please set/delete bilingual settings
    func localized() -> String {
        return "please set/delete bilingual settings"
    }
    
    func phoneNumberFormat() -> String {
        //Replacing +62 with 0
        return self.replacingOccurrences(of: "+62", with: "0")
    }
    
    func replace_fromStart(str:String , endIndex:Int , With:String) -> String {
        var strReplaced = str ;
        let start = str.startIndex;
        let end = str.index(str.startIndex, offsetBy: endIndex);
        strReplaced = str.replacingCharacters(in: start..<end, with: With) ;
        return strReplaced;
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var isValidEmail: Bool {
        let emailRegex = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
