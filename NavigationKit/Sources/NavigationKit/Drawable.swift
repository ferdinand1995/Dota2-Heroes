//
//  Drawable.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

public protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    public var viewController: UIViewController? { return self }
}
