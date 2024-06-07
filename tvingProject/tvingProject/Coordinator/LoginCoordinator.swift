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
        
        var loginSuccess: Bool = false
        
        // true면 main 으로 가는 로직입니다. 이부분을 통해서 뷰 테스트를 할 수 있습니다.
        // 테스트 용도로만 쓰고 항상 false로 유지하세요
        
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel()
        )
        
        let homeViewController = TVINGTabBarController()
        
        let mainViewController = loginSuccess ? homeViewController : loginViewController
        
        loginViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
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
