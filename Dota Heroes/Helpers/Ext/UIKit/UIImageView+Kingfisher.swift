//
//  UIImageView+Kingfisher.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ url: URL?, _ completion: @escaping () -> ()) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(named: "ic_placeholder"), options: [
                .transition(.fade(0.3)),
                .processor(DownsamplingImageProcessor(size: self.frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
        ]) { _ in
            completion()
        }

    }
}

