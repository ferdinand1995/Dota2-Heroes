//
//  InformationDialog.swift
//
//
//  Created by Ferdinand on 09/10/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class InformationDialog: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogImageView: UIImageView!
    @IBOutlet weak var informationTitleDialog: UILabel!
    @IBOutlet weak var closeDialogButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = 24
    }
    
    @IBAction func closeDialog(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
