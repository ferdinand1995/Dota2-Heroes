//
//  HeroCollectionViewCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 01/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var labelNameHero: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBackground.layer.borderColor = UIColor.lightGray.cgColor
        viewBackground.layer.borderWidth = 0.9
        viewBackground.layer.masksToBounds = true
        viewBackground.layer.cornerRadius = 6

        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.6
        self.contentView.layer.shadowRadius = 3
        self.contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

}
