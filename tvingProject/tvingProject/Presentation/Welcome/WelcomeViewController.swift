//
//  WelcomeViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let welcomeView = WelcomeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        bindActions()
    }
    
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        let backImage = UIImage(resource: .icLeftArrow)
        navigationController?.navigationBar.tintColor = .gray2
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
    }
    
    private func bindActions() {
        welcomeView.backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    }
    
    func setWelcomeLabel(welcomeText: String) {
        welcomeView.welcomeLabel.text = "\(welcomeText) 님 반갑습니다."
    }
    
    // MARK: - @objc Function
    
    @objc
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
