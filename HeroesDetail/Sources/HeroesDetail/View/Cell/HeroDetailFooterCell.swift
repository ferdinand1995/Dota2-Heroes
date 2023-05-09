//
//  HeroDetailFooterCell.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import UIKit
import SDWebImage

class HeroDetailFooterCell: UITableViewCell {

    @IBOutlet private weak var similarHero1: UIImageView!
    @IBOutlet private weak var similarHero2: UIImageView!
    @IBOutlet private weak var similarHero3: UIImageView!
    
    func configCell(_ viewModel: HeroDetailFooterVM) {
        similarHero1.sd_setImage(with: URL(string: viewModel.similarHero1 ?? ""))
        similarHero2.sd_setImage(with: URL(string: viewModel.similarHero2 ?? ""))
        similarHero3.sd_setImage(with: URL(string: viewModel.similarHero3 ?? ""))

    }

}
