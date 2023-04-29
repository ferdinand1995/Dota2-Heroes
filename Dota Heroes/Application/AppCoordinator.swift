//
//  AppCoordinator.swift
//  Dota Heroes
//
//  Created by Tedjakusuma, Ferdinand on 29/04/23.
//  Copyright © 2023 Tiket.com. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    let window: UIWindow

    init(_ window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        /// preparing root view
        let navigationController = UINavigationController()
        let heroesCoordinator = HeroesCoordinator(navigationController: navigationController)

        /// store child coordinator
        self.store(coordinator: heroesCoordinator)
        heroesCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        /// detect when free it
        heroesCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: heroesCoordinator)
        }
    }
}
