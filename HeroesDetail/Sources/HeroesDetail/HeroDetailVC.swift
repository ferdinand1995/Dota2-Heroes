//
//  HeroDetailVC.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 02/05/23.
//

import UIKit
import SnapKit

class HeroDetailVC: UIViewController {

    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(box)
        box.backgroundColor = .green
        box.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
    }

}
