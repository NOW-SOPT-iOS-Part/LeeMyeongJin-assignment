//
//  WelcomeViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let rootView = WelcomeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setAddTarget()
    }
    
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        let backImage = UIImage(resource: .icLeftArrow)
        navigationController?.navigationBar.tintColor = .gray2
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
    }
    
    private func setAddTarget() {
        rootView.mainButton.addTarget(self, action: #selector(pushToHomeViewController), for: .touchUpInside)
    }
    
    func setWelcomeLabel(welcomeText: String) {
        rootView.welcomeLabel.text = "\(welcomeText) 님 반갑습니다."
    }
    
    // MARK: - @objc Function
    
    @objc
    private func pushToHomeViewController() {
        
        guard let window = self.view.window else { return }
        
        let homeViewController = TVINGTabBarController()
        window.rootViewController = homeViewController
        window.makeKeyAndVisible()
    }
    
    @objc
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
