//
//  HeroCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientLayer.type = .axial
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.1)
        gradientLayer.endPoint = .init(x: 0, y: 1)
        gradientLayer.zPosition = 1
        gradientLayer.opacity = 0.6
        titleBackgroundView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCellView.roundViewCorner(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        gradientLayer.frame = titleBackgroundView.bounds
        titleBackgroundView.clipsToBounds = true
        heroImageView.clipsToBounds = true
    }
}
