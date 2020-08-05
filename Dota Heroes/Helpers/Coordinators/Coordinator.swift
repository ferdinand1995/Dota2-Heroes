//
//  Coordinator.swift
//  Dota Heroes
//
//  Created by Ferdinand on 04/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func mainView()
}
