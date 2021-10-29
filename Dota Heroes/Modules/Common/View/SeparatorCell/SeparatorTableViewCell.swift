//
//  SeparatorTableViewCell.swift
//  MySiloam
//
//  Created by DSS-Titus on 15/11/19.
//  Copyright © 2019 siloamhospital. All rights reserved.
//

import UIKit

class SeparatorTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func setCell(text: String, textColor: UIColor = .MAIN_PLACEHOLDER_COLOR) {
        titleLabel.text = text
        titleLabel.textColor = textColor
    }
}
