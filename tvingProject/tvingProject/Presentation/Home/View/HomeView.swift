//
//  HomeView.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import SnapKit
import Then

final class HomeView: UIView {
    
    // MARK: - UIComponents
    
    private let homeTopView = HomeTopView()
    
    lazy var homeCollectionView: UICollectionView = {
        let layout = CompositionalLayout.createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
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
        backgroundColor = .black
    }
    
    private func setHierarchy() {
        addSubview(homeCollectionView)
        
        homeCollectionView.addSubviews(
            homeTopView
        )
    }
    
    private func setLayout() {
        
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        homeTopView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
