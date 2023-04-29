//
//  CoreUIImage.swift
//  Diabetic Educator iOS (iOS)
//
//  Created by DSS-Titus on 10/08/21.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    /// Convert a label to an image
    class func imageFromLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        self.init(data: imageData)
    }
}
