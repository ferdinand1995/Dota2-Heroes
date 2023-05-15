//
//  HeroCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {

    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var backgroundCellView: UIView!
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var titleBackgroundView: UIView!
    @IBOutlet private weak var heroNameLabel: UILabel!

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
//        shadowView.dropShadow(color: .black, opacity: 0.1, offSet: CGSize(width: 0, height: 0.1), radius: 0.8)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCellView.roundViewCorner(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        gradientLayer.frame = titleBackgroundView.bounds
        titleBackgroundView.clipsToBounds = true
        heroImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        heroImageView.kf.cancelDownloadTask()
    }

    public func configCell(with viewModel: HeroesCellVM) {
        heroNameLabel.text = viewModel.name
        guard let url = viewModel.imageURL else { return }
        heroImageView.setImage(url) { image in
            self.heroImageView.image = image
            self.layoutSubviews()
            self.heroNameLabel.fadeIn()
        }
    }
}
