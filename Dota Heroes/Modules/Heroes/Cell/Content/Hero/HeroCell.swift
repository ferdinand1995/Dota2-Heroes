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
        viewBackground.roundViewCorner(cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
    }
}
