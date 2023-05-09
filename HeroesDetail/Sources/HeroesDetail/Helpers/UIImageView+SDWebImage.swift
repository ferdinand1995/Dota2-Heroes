//
//  File.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import Foundation
import SDWebImage

extension UIImageView {
    func setImage(url: String, placeholderImage: UIImage?, completion: @escaping (_ _result: Any?) -> Void) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            if error == nil {
                self.image = image
                completion(true)
            }
        })
    }
}
