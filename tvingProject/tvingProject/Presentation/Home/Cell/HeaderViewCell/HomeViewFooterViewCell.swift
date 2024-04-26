//
//  HomeViewFooterViewCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/26/24.
//

import UIKit
import Combine
import Foundation

import SnapKit

final class HomeViewFooterViewCell: UICollectionReusableView {
    
    // MARK: - Properties
    private let bannerPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private let cancelBag = CancelBag()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubview(bannerPageControl)
    }
    
    private func setLayout() {
        bannerPageControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func bind(input: PassthroughSubject<Int, Never>, indexPath: IndexPath, pageNumber: Int) {
        bannerPageControl.numberOfPages = pageNumber
        if indexPath.section == 1 {
            self.isHidden = true
        } else {
            input
                .debounce(for: 0.15, scheduler: RunLoop.main)
                .sink { [weak self] currentPage in
                print(currentPage)
                self?.bannerPageControl.currentPage = currentPage
            }.store(in: cancelBag)
        }
    }
}
