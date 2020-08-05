//
//  CustomFlowLayout.swift
//  Dota Heroes
//
//  Created by Ferdinand on 03/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class StretchyHeaderViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                
                guard let collectionView = collectionView else { return }
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY < 0 {
                    let width = collectionView.frame.width
                    let height = attribute.frame.height - contentOffsetY
                    attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                }
            }
        })
        
        return layoutAttributes
    }
    
    // 6. invalidate the layout for new bounds
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
