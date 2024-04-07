//
//  WelcomeViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let welcomeImage = UIImageView().then {
        $0.image = UIImage(resource: .imgTVING)
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .black
        
        
        let backImage = UIImage(resource: .icLeftArrow)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
        self.navigationController?.navigationBar.tintColor = .gray2
    }
    
    private func setHierarchy() {
        view.addSubviews(welcomeImage)
    }
    
    private func setLayout() {
        
        welcomeImage.snp.makeConstraints {
            $0.height.equalTo(210.94)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(14)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    private func setDelegate() {
        
    }
    
    private func setRegister() {
        
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
