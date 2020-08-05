//
//  RolesCollectionViewCell.swift
//  Dota Heroes
//
//  Created by Ferdinand on 02/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class RolesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBackground.layer.borderColor = UIColor.lightGray.cgColor
        viewBackground.layer.borderWidth = 0.9
        viewBackground.layer.masksToBounds = false
        viewBackground.layer.cornerRadius = 9

        viewBackground.layer.shadowColor = UIColor.black.cgColor
        viewBackground.layer.shadowOpacity = 0.6
        viewBackground.layer.shadowRadius = 3
        viewBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
