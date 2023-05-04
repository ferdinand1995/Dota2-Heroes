//
//  CoreUIViewController.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {

    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        self.view.addSubview(child.view)
        child.view.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            child.view.alpha = 1
        } completion: { _ in
            child.didMove(toParent: self)
        }
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.view.alpha = 0.0
        } completion: { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
