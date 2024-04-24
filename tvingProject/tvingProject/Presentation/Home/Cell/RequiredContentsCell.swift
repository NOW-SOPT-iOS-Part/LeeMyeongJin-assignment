//
//  RequiredContentsCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import SnapKit
import Then

class RequiredContentsCell: UICollectionViewCell, ImageBindable {
    
    // MARK: - UIComponents
    
    private var mainImageView = UIImageView().then {
        $0.image = UIImage(resource: .mainImage2)
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
    
    func bindData(image: UIImage) {
        self.mainImageView.image = image
    }
    
}
