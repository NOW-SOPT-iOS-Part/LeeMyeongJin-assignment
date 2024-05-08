//
//  MainCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

final class MainCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    private let mainImageView = UIImageView().then {
        $0.image = UIImage(resource: .mainImage1)
    }
    
    private let imageTitle = UILabel().then {
        $0.text = "제목"
        $0.font = .pretendardFont(weight: 700, size: 25)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    private let imageInfo = UILabel().then {
        $0.text = "궁시렁 궁시럼 내용"
        $0.font = .pretendardFont(weight: 500, size: 14)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    private lazy var mainBannerVStackView = UIStackView(
        arrangedSubviews: [
            imageTitle,
            imageInfo
        ]
        
    ).then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(mainImageView)
        mainImageView.addSubview(mainBannerVStackView)
    }
    
    private func setLayout() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainBannerVStackView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.leading).offset(16)
            $0.bottom.equalTo(mainImageView.snp.bottom).inset(28)
        }
    }
    
    func bindData(image: UIImage, title: String = "기본", info: String = "기본 내용") {
        self.mainImageView.image = image
        self.imageTitle.text = title
        self.imageInfo.text = info
    }
    
}
