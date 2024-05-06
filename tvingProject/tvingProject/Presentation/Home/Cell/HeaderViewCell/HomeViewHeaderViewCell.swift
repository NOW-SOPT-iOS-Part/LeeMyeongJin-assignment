//
//  HomeViewHeaderViewCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewHeaderViewCell: UICollectionReusableView {
    // MARK: - UIComponents
    
    private let titleLabel = UILabel().then {
        $0.text = "티빙에서 꼭 봐야하는 콘텐츠"
        $0.font = .pretendardFont(weight: 600, size: 15)
        $0.textColor = .white
    }
    
    private let viewAllLabel = UILabel().then {
        $0.text = "전체보기 >"
        $0.font = .pretendardFont(weight: 500, size: 12)
        $0.textColor = .white
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
        addSubviews(
            titleLabel,
            viewAllLabel
        )
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        viewAllLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func bindTitle(title: String) {
        self.titleLabel.text = title
    }
}
