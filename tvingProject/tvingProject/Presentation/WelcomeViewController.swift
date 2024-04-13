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
    
    private let welcomeLabel = UILabel().then {
        $0.text = ""
        $0.font = .pretendardFont(weight: 700, size: 23)
        $0.textColor = .gray1
        $0.numberOfLines = 2
    }
    
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
        view.addSubviews(welcomeImage, welcomeLabel)
    }
    
    private func setLayout() {
        
        welcomeImage.snp.makeConstraints {
            $0.height.equalTo(210.94)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(14)
            $0.leading.trailing.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        
    }
    
    private func setRegister() {
        
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setWelcomeLabel(welcomeLabel: String) {
        self.welcomeLabel.text = welcomeLabel
    }
    
}
