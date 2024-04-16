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
    
    private let welcomeLabel = UILabel().then {
        $0.text = ""
        $0.font = .pretendardFont(weight: 700, size: 23)
        $0.textColor = .gray1
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private let welcomeImage = UIImageView().then {
        $0.image = UIImage(resource: .imgTVING)
    }
    
    private lazy var backButton = UIButton().then {
        $0.setTitle("메인으로", for: .normal)
        $0.titleLabel?.font = .pretendardFont(weight: 600, size: 14)
        $0.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        $0.backgroundColor = .tvingRed
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .black
        
        
        let backImage = UIImage(resource: .icLeftArrow)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
        self.navigationController?.navigationBar.tintColor = .gray2
    }
    
    private func setHierarchy() {
        view.addSubviews(
            welcomeImage,
            welcomeLabel,
            backButton
        )
    }
    
    private func setLayout() {
        
        welcomeImage.snp.makeConstraints {
            $0.height.equalTo(210.94)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(14)
            $0.leading.trailing.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(67)
            $0.leading.trailing.equalToSuperview().inset(65)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(66)
            $0.height.equalTo(52)
        }
        
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setWelcomeLabel(welcomeLabel: String) {
        self.welcomeLabel.text = "\(welcomeLabel) 님 반갑습니다."
    }
    
}
