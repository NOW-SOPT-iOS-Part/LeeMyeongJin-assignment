//
//  SceneDelegate.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: LoginCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let navigationController = UINavigationController()
        coordinator = LoginCoordinator(
            navigationController: navigationController,
            window: window
        )
        coordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

