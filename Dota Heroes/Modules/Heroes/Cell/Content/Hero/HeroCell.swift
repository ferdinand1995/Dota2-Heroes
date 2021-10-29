//
//  HeroCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var labelNameHero: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        labelNameHero.alpha = 0
        DispatchQueue.main.async {
            self.viewBackground.dropShadow(shadowCell: 0.25, shadowRadius: 3, offsetHeight: 2)
            self.labelNameHero.dropShadow(shadowCell: 0.6, shadowRadius: 3, offsetHeight: 2)
        }
        viewBackground.roundViewCorner(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        imageViewHero.roundViewCorner(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
    }
}
