//
//  MagicMovieCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

final class MagicMovieCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    private var mainImageView = UIImageView().then {
        $0.image = UIImage(resource: .mainImage1)
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

