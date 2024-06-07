//
//  LoginCoordinator.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    var window: UIWindow
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    // MARK: - Start
    
    func start() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel()
        )
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    
    // MARK: - Coordinator
    
    func showWelcomeViewController(nickname: String) {
        let welcomeViewModel = WelcomeViewModel()
        let welcomeViewController = WelcomeViewController(
            viewModel: welcomeViewModel
        )
        welcomeViewController.coordinator = self
        welcomeViewController.setWelcomeLabel(welcomeText: nickname)
        navigationController.pushViewController(welcomeViewController, animated: true)
    }
    
    func showHomeViewController() {
        let homeViewController = TVINGTabBarController()
        
        ViewControllerUtils.setRootViewController(
            window: window,
            viewController: homeViewController,
            withAnimation: true
        )
    }
}
