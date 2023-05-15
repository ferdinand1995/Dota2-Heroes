//
//  HeroDetailContentCell.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 09/05/23.
//

import UIKit

class HeroDetailContentCell: UITableViewCell {

    @IBOutlet private weak var baseAttackLabel: UILabel!
    @IBOutlet private weak var attrLabel: UILabel!
    @IBOutlet private weak var defenseLabel: UILabel!
    @IBOutlet private weak var moveSpeedLabel: UILabel!
    @IBOutlet private weak var manaLabel: UILabel!
    @IBOutlet private weak var healthLabel: UILabel!

    func configCell(_ viewModel: HeroDetailContentVM) {
        baseAttackLabel.text = viewModel.baseAttack
        attrLabel.text = viewModel.primaryAttr
        defenseLabel.text = viewModel.armor
        moveSpeedLabel.text = viewModel.moveSpeed
        manaLabel.text = viewModel.baseMana
        healthLabel.text = viewModel.health
    }
}
