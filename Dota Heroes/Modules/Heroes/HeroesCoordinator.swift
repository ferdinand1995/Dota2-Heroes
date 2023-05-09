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

        let viewModel = HeroesVM()
        let heroesVC = HeroesVC(viewModel)

        viewModel.didSelect = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showDetail(strongSelf.router, viewModel)
        }

        viewModel.didTapBack = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.isCompleted?()
        }
        router.push(heroesVC, isAnimated: true, onNavigateBack: isCompleted)
    }

    func showDetail(_ router: RouterProtocol, _ data: AnyObject) {
        guard let heroesVM = data as? HeroesVM else { return }
        do {
            let jsonData = try JSONEncoder().encode(heroesVM.selectedHero)
            let heroDetailCoordinator = HeroDetailCoordinator(router, jsonData)
            self.start(coordinator: heroDetailCoordinator)
        } catch {
            print("Error: ", error)
        }
    }
}
