//
//  HeroDetailFooterCell.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import UIKit

class HeroDetailFooterCell: UITableViewCell {

    @IBOutlet private weak var similarHero1: UIImageView!
    @IBOutlet private weak var similarHero2: UIImageView!
    @IBOutlet private weak var similarHero3: UIImageView!
    
    func configCell(_ viewModel: HeroDetailFooterVM) {
        guard let url1 = URL(string: viewModel.similarHero1 ?? "") else { return }
        similarHero1.setImage(url: url1, completion: { [weak self] image in
            guard let strongSelf = self else { return }
            strongSelf.similarHero1.image = image
            strongSelf.layoutSubviews()
        })
        guard let url2 = URL(string: viewModel.similarHero2 ?? "") else { return }
        similarHero2.setImage(url: url2, completion: { [weak self] image in
            guard let strongSelf = self else { return }
            strongSelf.similarHero2.image = image
            strongSelf.layoutSubviews()
        })
        guard let url3 = URL(string: viewModel.similarHero3 ?? "") else { return }
        similarHero3.setImage(url: url3, completion: { [weak self] image in
            guard let strongSelf = self else { return }
            strongSelf.similarHero3.image = image
            strongSelf.layoutSubviews()
        })
    }

}
