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

    func confiCell(_ viewModel: HeroDetailHeaderVM) {
        heroNameLabel.text = viewModel.name
        rolesLabel.text = viewModel.roles
        heroIconImageView.setImage(url: viewModel.imgUrl, placeholderImage: nil) { _ in }
    }

}
