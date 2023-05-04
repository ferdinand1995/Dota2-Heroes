//
//  BaseCoordinator.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

open class BaseCoordinator: Coordinator {
    public var childCoordinators = [Coordinator]()
    public var isCompleted: (() -> ())?

    public init() { }

    open func start() {
        fatalError("Children should implement `start`.")
    }

    open func start(coordinator: BaseCoordinator) {
        self.store(coordinator: coordinator)
        coordinator.isCompleted = { [weak self, weak coordinator] in
            self?.free(coordinator: coordinator)
        }
        coordinator.start()
    }
}
