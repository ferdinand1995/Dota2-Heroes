//
//  HeroDetailHeaderCell.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import UIKit

class HeroDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var rolesLabel: UILabel!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroIconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func confiCell(_ viewModel: HeroDetailHeaderVM) {
//        heroNameLabel.text
    }
    
}
