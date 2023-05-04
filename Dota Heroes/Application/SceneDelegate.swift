//
//  SceneDelegate.swift
//  Dota Heroes
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?
        
    private var dialogTransitioningDelegate: DialogTransitioningDelegate?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let window = window else { return }
        let appCoordinator = AppCoordinator(window)
        appCoordinator.start()
        self.coordinator = appCoordinator
        
        /// - NOTE: Activity Indicator Style
        var style = ToastStyle()
        style.activityBackgroundColor = .hexStringToUIColor("#CED0DF")
        style.activityIndicatorColor = .MAIN_BLACK_COLOR
        ToastManager.shared.style = style
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}
/*
extension SceneDelegate {
    
    func setupReachability(){
        do {
            try reachability.startNotifier()
        }catch {
            print(error.localizedDescription)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection == .unavailable {
            let informationDialog = InformationDialog()

            guard let window = self.window, let rootViewController = window.rootViewController else { return }

            dialogTransitioningDelegate = DialogTransitioningDelegate(from: rootViewController, to: informationDialog)
            informationDialog.modalPresentationStyle = .custom
            informationDialog.transitioningDelegate = dialogTransitioningDelegate

            if rootViewController.presentedViewController == nil {
                rootViewController.present(informationDialog, animated: true, completion: nil)
            }else {
                rootViewController.dismiss(animated: false) { () -> Void in
                    rootViewController.present(informationDialog, animated: true, completion: nil)
                }
            }
        }
    }
}*/

