//
//  WelcomeView.swift
//  tvingProject
//
//  Created by 이명진 on 4/16/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeView: UIView {
    
    // MARK: - UIComponents
    
    let welcomeLabel = UILabel().then {
        $0.text = ""
        $0.font = .pretendardFont(weight: 700, size: 23)
        $0.textColor = .gray1
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    let welcomeImage = UIImageView().then {
        $0.image = UIImage(resource: .imgTVING)
    }
    
    let backButton = UIButton().then {
        $0.setTitle("메인으로", for: .normal)
        $0.titleLabel?.font = .pretendardFont(weight: 600, size: 14)
        $0.backgroundColor = .tvingRed
    }
    
    
    // MARK: - init
    
    override init(frame: CGRect = .zero) {
        
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .black
    }
    
    private func setHierarchy() {
        addSubviews(
            welcomeImage,
            welcomeLabel,
            backButton
        )
    }
    
    private func setLayout() {
        welcomeImage.snp.makeConstraints { make in
            make.height.equalTo(210.94)
            make.top.equalTo(safeAreaLayoutGuide).offset(14)
            make.leading.trailing.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeImage.snp.bottom).offset(67)
            make.leading.trailing.equalToSuperview().inset(65)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(66)
            make.height.equalTo(52)
        }
    }
}

