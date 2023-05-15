//
//  UIImageView+SDWebImage.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 12/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func setImage(_ url: URL?, _ completion: @escaping (_ image: UIImage) -> Void) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_imageIndicator?.startAnimatingIndicator()
        SDWebImageManager.shared.loadImage(
            with: url,
            options: [.scaleDownLargeImages, .continueInBackground, .lowPriority],
            progress: nil,
            completed: { [weak self] (image, data, error, cacheType, finished, imageURL) in
                guard let strongSelf = self else { return }
                guard error == nil else { return }
                guard let image = image else { return }
                completion(image)
                strongSelf.self.sd_imageIndicator?.stopAnimatingIndicator()
            })
    }
}

