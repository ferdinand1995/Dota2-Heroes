//
//  AlertSheetView.swift
//  Diabetic Educator
//
//  Created by Ferdinand on 13/08/21.
//

import UIKit

class AlertSheetView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var alertBackgroundView: UIView!

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
        self.sheetView.layer.mask = mask
    }

    private func commonInit() {
        let viewFromXIB = Bundle.main.loadNibNamed("AlertSheetView", owner: self, options: nil)![0] as! UIView
        addSubview(viewFromXIB)
        viewFromXIB.frame = self.bounds
        viewFromXIB.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sheetView.transform = CGAffineTransform(translationX: 0, y: 500)
        alertBackgroundView.isUserInteractionEnabled = true
        alertBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTapped(_:))))
    }

    //MARK: Animate
    func animateOpeningView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let ws = self else { return }
            ws.sheetView.transform = CGAffineTransform.identity
        }, completion: nil)
    }

    @objc func dismissTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.8 , delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let ws = self else { return }
            ws.sheetView.frame.origin.y += 200
            ws.sheetView?.layoutIfNeeded()
        }, completion: { _ in
            self.subscribeSheetAction?()
        })
    }
}
