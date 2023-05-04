//
//  BloodRecordNotFoundView.swift
//  MySiloam
//
//  Created by Ferdinand on 18/07/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit

class RecordNotFoundView: UIView {
    
    @IBOutlet weak var noRecordImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let viewFromXIB = Bundle.main.loadNibNamed("RecordNotFoundView", owner: self, options: nil)![0] as! UIView
        addSubview(viewFromXIB)
        viewFromXIB.frame = self.bounds
        viewFromXIB.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        actionButton.underlined(text: "Change filter".uppercased(), color: .MAIN_BLUE_COLOR)

    }
}

