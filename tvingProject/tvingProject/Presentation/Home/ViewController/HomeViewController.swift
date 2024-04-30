//
//  HomeViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit
import Combine

import Then

enum HomeSection: Int, CaseIterable {
    case main = 0
    case required
    case popular
    case paraMount
    case advertise
    case magicMovie
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var scrollDelegate: HomeViewScrollDelegate?
    
    private let titleLists: [String] = [
        "티빙에서 꼭 봐야하는 콘텐츠",
        "인기 LIVE 채널",
        "1화 무료! 파라마운트+ 인기 시리즈",
        "마술보다 더 신비로운 영화(신비로운 영화사전님)"
    ]
    
    // dummyData 입니다.
    private let imagesBySection: [Int: [UIImage]] = [
        0: [UIImage(resource: .mainImage7), UIImage(resource: .mainImage8), UIImage(resource: .mainImage3), UIImage(resource: .mainImage7), UIImage(resource: .mainImage8)],
        1: [UIImage(resource: .mainImage9), UIImage(resource: .mainImage4), UIImage(resource: .thingjin), UIImage(resource: .mainImage5), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1)],
        2: [UIImage(resource: .imgLive1), UIImage(resource: .imgLive2), UIImage(resource: .imgLive1), UIImage(resource: .imgLive2)],
        3: [UIImage(resource: .mainImage1), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage7)],
        4: [UIImage(resource: .imgAd1), UIImage(resource: .imgAd2), UIImage(resource: .mainImage2), UIImage(resource: .imgLive2)],
        5: [UIImage(resource: .mainImage8), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage1)]
    ]
    
    private var mainModelItems: [mainModel] = mainModel.getData()
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        homeView.homeCollectionView.delegate = self
        homeView.homeCollectionView.dataSource = self
    }
    
    private func setRegister() {
        homeView.homeCollectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.className)
        homeView.homeCollectionView.register(RequiredContentsCell.self, forCellWithReuseIdentifier: RequiredContentsCell.className)
        homeView.homeCollectionView.register(PopularLIVECell.self, forCellWithReuseIdentifier: PopularLIVECell.className)
        homeView.homeCollectionView.register(ParaMountPlus.self, forCellWithReuseIdentifier: ParaMountPlus.className)
        homeView.homeCollectionView.register(AdvertiseCell.self, forCellWithReuseIdentifier: AdvertiseCell.className)
        homeView.homeCollectionView.register(MagicMovieCell.self, forCellWithReuseIdentifier: MagicMovieCell.className)
        
        homeView.homeCollectionView.register(HomeViewHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeViewHeaderViewCell.className)
        homeView.homeCollectionView.register(HomeViewFooterViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeViewFooterViewCell.className)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeSection(rawValue: indexPath.section)!
        
        switch section {
        case .main:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.className, for: indexPath) as! MainCell
            let model = mainModelItems[indexPath.row]
            cell.bindData(image: model.image, title: model.title, info: model.info)
            return cell
            
        case .required:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequiredContentsCell.className, for: indexPath) as! RequiredContentsCell
            
            if let item = imagesBySection[1] {
                cell.bindData(image: item[indexPath.row])
            }
            return cell
            
        case .popular:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularLIVECell.className, for: indexPath) as! PopularLIVECell
            
            if let item = imagesBySection[2] {
                cell.bindData(image: item[indexPath.row])
            }
            return cell
            
        case .paraMount:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParaMountPlus.className, for: indexPath) as! ParaMountPlus
            
            if let item = imagesBySection[3] {
                cell.bindData(image: item[indexPath.row])
            }
            return cell
            
        case .advertise:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertiseCell.className, for: indexPath) as! AdvertiseCell
            
            if let item = imagesBySection[4] {
                cell.bindData(image: item[indexPath.row])
            }
            return cell
            
        case .magicMovie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MagicMovieCell.className, for: indexPath) as! MagicMovieCell
            
            if let item = imagesBySection[5] {
                cell.bindData(image: item[indexPath.row])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewHeaderViewCell.className, for: indexPath) as? HomeViewHeaderViewCell else {
                return UICollectionReusableView()
            }
            let section = HomeSection(rawValue: indexPath.section)!
            switch section {
            case .required:
                headerView.bindTitle(title: titleLists[0])
            case .popular:
                headerView.bindTitle(title: titleLists[1])
            case .paraMount:
                headerView.bindTitle(title: titleLists[2])
            case .magicMovie:
                headerView.bindTitle(title: titleLists[3])
            default:
                headerView.bindTitle(title: "")
            }
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewFooterViewCell.className, for: indexPath) as? HomeViewFooterViewCell else {
                return UICollectionReusableView()
            }
            let section = HomeSection(rawValue: indexPath.section)!
            if section == .main {
                footerView.bind(input: homeView.currentBannerPage, indexPath: indexPath, pageNumber: 8)
                return footerView
            }
        default:
            return UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.homeViewDidScroll(yOffset: scrollView.contentOffset.y)
    }
}


// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    // Implement any specific delegate methods you might need
}
