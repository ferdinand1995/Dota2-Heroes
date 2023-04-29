//
//  MainCoordinator.swift
//  Dota Heroes
//
//  Created by Ferdinand on 04/08/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class HeroesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func mainView() {
        let viewController = HeroesVC.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func detailDescription() {
        let detailsViewController = HeroDetailsVC.instantiate()
        detailsViewController.coordinator = self
        navigationController.pushViewController(detailsViewController, animated: true)
    }

}
