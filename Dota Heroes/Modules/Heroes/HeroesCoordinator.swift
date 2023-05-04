//
//  HeroesCoordinator.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 29/04/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import UIKit
import NavigationKit
import HeroesDetail

class HeroesCoordinator: BaseCoordinator {

    let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {

        let heroesVC = HeroesVC()
        let viewModel = HeroesVM()
        heroesVC.viewModel = viewModel

        viewModel.didSelect = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showDetail(strongSelf.router)
        }

        viewModel.didTapBack = { [weak self] in
            self?.isCompleted?()
        }
        router.push(heroesVC, isAnimated: true, onNavigateBack: isCompleted)
    }

    func showDetail(_ router: RouterProtocol) {
        let heroDetailCoordinator = HeroDetailCoordinator(router)
        self.start(coordinator: heroDetailCoordinator)
    }
}
