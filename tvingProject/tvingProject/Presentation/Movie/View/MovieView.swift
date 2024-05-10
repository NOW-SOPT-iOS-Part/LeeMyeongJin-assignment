//
//  MovieView.swift
//  tvingProject
//
//  Created by 이명진 on 5/8/24.
//

import UIKit

import SnapKit
import Then

final class MovieView: UIView {
    
    // MARK: - UIComponents
    
    lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .white
    }
    
    private func setHierarchy() {
        addSubview(movieCollectionView)
    }
    
    private func setLayout() {
        movieCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

