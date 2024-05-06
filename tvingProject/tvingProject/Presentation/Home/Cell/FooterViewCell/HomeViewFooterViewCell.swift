//
//  HomeViewFooterViewCell.swift
//  tvingProject
//
//  Created by 이명진 on 4/26/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class HomeViewFooterViewCell: UICollectionReusableView {
    
    // MARK: - UIComponents
    
    private let bannerPageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = .gray3
        $0.currentPageIndicatorTintColor = .white
        $0.currentPage = 0
        $0.isUserInteractionEnabled = false
    }
    
    private var cancelBag = CancelBag()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setPageControlSize(scale: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        addSubview(bannerPageControl)
    }
    
    private func setLayout() {
        bannerPageControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setPageControlSize(scale: CGFloat) {
        bannerPageControl.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    // MARK: - Methods
    
    func bind(input: PassthroughSubject<Int, Never>, indexPath: IndexPath, pageNumber: Int) {
        bannerPageControl.numberOfPages = pageNumber
        
        input
            .debounce(for: 0.15, scheduler: RunLoop.main)
            .sink { [weak self] currentPage in
                print(currentPage)
                self?.bannerPageControl.currentPage = currentPage
            }.store(in: cancelBag)
    }
}

