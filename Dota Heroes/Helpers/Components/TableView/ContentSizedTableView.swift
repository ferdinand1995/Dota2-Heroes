//
//  ContentSizedTableView.swift
//  MySiloam
//
//  Created by Ferdinand on 07/07/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
