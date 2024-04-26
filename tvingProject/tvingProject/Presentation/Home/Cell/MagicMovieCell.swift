//
//  MagicMovieCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

class MagicMovieCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    private var mainImageView = UIImageView().then {
        $0.image = UIImage(resource: .mainImage1)
    }
    
    private let rankingLabel = UILabel().then {
        $0.text = "1"
        $0.font = .pretendardFont(weight: 700, size: 19)
    }
    
    private let title = UILabel().then {
        $0.text = "1"
        $0.font = .pretendardFont(weight: 700, size: 19)
    }
    
    private let episodes = UILabel().then {
        $0.text = "1"
        $0.font = .pretendardFont(weight: 700, size: 19)
    }
    
    private let viewerShipRatings = UILabel().then {
        $0.text = "1"
        $0.font = .pretendardFont(weight: 700, size: 19)
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
        addSubview(mainImageView)
    }
    
    private func setLayout() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func bindData(image: UIImage) {
        self.mainImageView.image = image
    }
    
}

