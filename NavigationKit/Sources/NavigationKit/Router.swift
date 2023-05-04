//
//  Router.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

public typealias NavigationBackClosure = (() -> ())

public protocol RouterProtocol: AnyObject {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
}

public class Router: NSObject, RouterProtocol {

    public let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    public func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else {
            return
        }

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }

    public func pop(_ isAnimated: Bool) {
        guard let viewController = navigationController.popViewController(animated: isAnimated) else {
            return
        }
        executeClosure(viewController)
    }

    public func popToRoot(_ isAnimated: Bool) {
        guard let viewControllers = navigationController.popToRootViewController(animated: isAnimated) else {
            return
        }

        viewControllers.forEach { executeClosure($0) }
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension Router: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
            return
        }
        executeClosure(previousController)
    }
}
