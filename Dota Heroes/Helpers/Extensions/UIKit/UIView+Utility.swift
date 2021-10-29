//
//  CoreUIView.swift
//  Diabetic Educator iOS (iOS)
//
//  Created by DSS-Titus on 10/08/21.
//

import UIKit

extension UIView {

    func setDefaultCellUI(_ isRounded: Bool = true) {
        if isRounded {
            self.roundViewCorner(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        }
        self.dropShadow(shadowOpacity: 0.1, shadowRadius: 3, offsetHeight: 2)
        DispatchQueue.main.async {
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
    }

    func addShadowNavigationBar() {
        dropShadow(shadowOpacity: 0.1, shadowRadius: 3, offsetHeight: 2)
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: bounds.maxY - layer.shadowRadius, width: bounds.width, height: layer.shadowRadius)).cgPath
    }

    func circleIt() {
        self.roundViewCorner(cornerRadius: self.frame.height / 2, borderWidth: 0, borderColor: .clear)
    }

    func roundViewCorner(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }

    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)) {
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)) {
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)) {
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)) {
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func dropShadow(shadowOpacity: Float, shadowRadius: CGFloat, offsetHeight: CGFloat, color: UIColor = .black) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: offsetHeight)
        self.layer.shadowRadius = shadowRadius

        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
    }

    func setGradientBackground(startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)

        self.layer.insertSublayer(gradient, at: 0)
    }

    func addSubviewAnimate(customView: UIView, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.addSubview(customView)
        }, completion: completion)
    }

    func removeSubviewAnimate(customView: UIView, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            customView.removeFromSuperview()
        }, completion: completion)
    }

    func fadeIn(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = { (finished: Bool) -> Void in }) {
        self.alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = { (finished: Bool) -> Void in }) {
        self.alpha = 1.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.3) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}
