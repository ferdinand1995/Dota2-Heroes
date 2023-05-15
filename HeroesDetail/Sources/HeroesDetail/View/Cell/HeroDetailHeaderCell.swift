//
//  HeroDetailHeaderCell.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import UIKit

class HeroDetailHeaderCell: UITableViewCell {

    @IBOutlet private weak var attackType: UIImageView!
    @IBOutlet private weak var rolesLabel: UILabel!
    @IBOutlet private weak var heroNameLabel: UILabel!
    @IBOutlet private weak var heroIconImageView: UIImageView!

    func confiCell(_ viewModel: HeroDetailHeaderVM) {
        heroNameLabel.text = viewModel.name
        rolesLabel.text = viewModel.roles
        attackType.image = viewModel.attackTypeIsRange ? UIImage(named: "ic_range", in: .module, compatibleWith: nil) : UIImage(named: "ic_melee", in: .module, compatibleWith: nil)
        guard let url = URL(string: viewModel.imgUrl) else { return }
        heroIconImageView.setImage(url: url, completion: { [weak self] image in
            guard let strongSelf = self else { return }
            strongSelf.heroIconImageView.image = image
            strongSelf.layoutSubviews()
        })
    }

}
