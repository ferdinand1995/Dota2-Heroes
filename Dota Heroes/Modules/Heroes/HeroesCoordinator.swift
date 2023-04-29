//
//  HeroesCoordinator.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 29/04/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import UIKit

class HeroesCoordinator: BaseCoordinator {

    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    override func start() {

        let viewModel = HeroesVM()
        let viewController = HeroesVC.instantiate()

        viewModel.didSelect = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showDetail(strongSelf.navigationController)
        }

        viewModel.didTapBack = { [weak self] in
            self?.isCompleted?()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    func showDetail(_ navigationController: UINavigationController?) {
//        let newCoordinator = NewCoordinator(product: product, navigationController: navigationController)
//        self.store(coordinator: newCoordinator)
    }
}
