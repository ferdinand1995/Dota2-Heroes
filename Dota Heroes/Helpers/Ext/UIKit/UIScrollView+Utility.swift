//
//  CoreUIScrollView.swift
//  Diabetic Educator iOS (iOS)
//
//  Created by DSS-Titus on 10/08/21.
//

import Foundation
import UIKit.UIScrollView

extension UIScrollView {
    func setDefaultBottomInset() {
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 34, right: 0)
    }
    
    func setCustomBottomInset(bottomInset: Int) {
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(bottomInset), right: 0)
    }
    
    func scrolledToBottom() -> Bool {
        let height = self.frame.size.height
        let contentYoffset = self.contentOffset.y
        let distanceFromBottom = self.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            return true
        }else {
            return false
        }
    }
    
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
