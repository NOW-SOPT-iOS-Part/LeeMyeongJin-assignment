//
//  PopularLIVECell.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import SnapKit
import Then

class PopularLIVECell: UICollectionViewCell, ImageBindable {
    
    // MARK: - UIComponents
    
    private var mainImageView = UIImageView().then {
        $0.image = UIImage(resource: .mainImage3)
    }
    
    private let rankingLabel = UILabel().then {
        $0.text = "1"
        $0.font = .pretendardFont(weight: 700, size: 18)
        $0.textColor = .white
    }
    
    private let title = UILabel().then {
        $0.text = "Mnet"
        $0.font = .pretendardFont(weight: 600, size: 10)
        $0.textColor = .white
    }
    
    private let episodes = UILabel().then {
        $0.text = "보이즈 플래닛 12화"
        $0.font = .pretendardFont(weight: 400, size: 10)
        $0.textColor = .white
    }
    
    private let viewerShipRatings = UILabel().then {
        $0.text = "80.0%"
        $0.font = .pretendardFont(weight: 400, size: 10)
        $0.textColor = .white
    }
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            title,
            episodes,
            viewerShipRatings
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
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
        addSubviews(
            mainImageView,
            rankingLabel,
            vStackView
        )
    }
    
    private func setLayout() {
        mainImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        rankingLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(8)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
    }
    
    func bindData(image: UIImage) {
        self.mainImageView.image = image
    }
    
    
}
