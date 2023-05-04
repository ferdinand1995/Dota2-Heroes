//
//  ChatMenuView.swift
//  Diabetic Educator
//
//  Created by Ferdinand on 13/09/21.
//

import UIKit

class MenuTableView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundMenuView: UIView!
    @IBOutlet weak var tableView: ContentSizedTableView!
    
    var subscribeSheetAction: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 24.0, height: 24.0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.backgroundMenuView.layer.mask = mask
    }

    private func commonInit() {
        let viewFromXIB = Bundle.main.loadNibNamed("MenuTableView", owner: self, options: nil)![0] as! UIView
        addSubview(viewFromXIB)
        viewFromXIB.frame = self.bounds
        viewFromXIB.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundMenuView.transform = CGAffineTransform(translationX: 0, y: 500)
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTapped(_:))))
    }

    //MARK: Animate
    func animateOpeningView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let ws = self else { return }
            ws.backgroundMenuView.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    @objc func dismissTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.8 , delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let ws = self else { return }
            ws.backgroundMenuView.frame.origin.y += 500
            ws.backgroundMenuView?.layoutIfNeeded()
        }, completion: { _ in
            self.subscribeSheetAction?()
        })
    }
}

