//
//  SceneDelegate.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
//        let navigationController = UINavigationController(rootViewController: TVINGTabBarController())
//        self.window?.rootViewController = LoginViewController(viewModel: LoginViewModel())
        self.window?.rootViewController = LoginViewController(viewModel: LoginViewModel())
        self.window?.makeKeyAndVisible()
    }
}

