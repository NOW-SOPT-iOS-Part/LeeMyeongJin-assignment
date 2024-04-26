//
//  HomeView.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class HomeView: UIView {
    
    // MARK: - UIComponents
    
    private let homeTopView = HomeLogoView()
    
    var currentBannerPage = PassthroughSubject<Int, Never>()
    
    lazy var homeCollectionView: UICollectionView = {
        let layout = CompositionalLayout.createLayout(currentBannerPage: currentBannerPage)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
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
        addSubview(self.homeCollectionView)
        
        self.homeCollectionView.addSubview(self.homeTopView)
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
