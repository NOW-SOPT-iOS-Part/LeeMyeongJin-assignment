//
//  HomeTopView.swift
//  tvingProject
//
//  Created by 이명진 on 4/24/24.
//

import UIKit

import SnapKit
import Then

final class HomeLogoView: UIView {
    
    // MARK: - UIComponents
    
    private let LogoIcon = UIImageView().then {
        $0.image = UIImage(resource: .icLogo)
    }
    
    private let profileImage = UIImageView().then {
        $0.image = UIImage(resource: .imgProfile)
    }
    
    private lazy var logoHStackView = UIStackView(
        arrangedSubviews: [
            LogoIcon,
            profileImage
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 223
        $0.alignment = .center
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
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
        backgroundColor = .clear
    }
    
    private func setHierarchy() {
        addSubview(logoHStackView)
    }
    
    private func setLayout() {
        logoHStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
}

