//
//  ParaMountPlus.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import SnapKit
import Then

final class ParaMountPlus: UICollectionViewCell {
    // MARK: - UIComponents
    
    private var mainImageView = UIImageView().then {
        $0.image = UIImage(resource: .mainImage4)
    }
    
    private let title = UILabel().then {
        $0.text = "시그널"
        $0.font = .pretendardFont(weight: 500, size: 10)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    private lazy var paraMountVStackView = UIStackView(
        arrangedSubviews: [
            mainImageView,
            title
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 4
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
        contentView.addSubview(paraMountVStackView)
    }
    
    private func setLayout() {
        paraMountVStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints {
            $0.height.equalTo(146)
        }
        
        title.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        
    }
    
    // MARK: - Methods
    
    func bindData(image: UIImage) {
        self.mainImageView.image = image
    }
}

