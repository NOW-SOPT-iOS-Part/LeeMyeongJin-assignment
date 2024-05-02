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
    
    var numberOfItemsInSection: Int {
        switch self {
        case .main, .required:
            return 8
        default:
            return 4
        }
    }
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var scrollDelegate: HomeViewScrollDelegate?
    
    // dummyDatas
    private let titleLists: [String] = mainModel.getTitleLists()
    private let imagesBySection: [Int: [UIImage]] = mainModel.getImageDatas()
    private let mainModelItems: [mainModel] = mainModel.getData()
    
    // MARK: - UI Components
    
    private let rootView = HomeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        rootView.homeCollectionView.delegate = self
        rootView.homeCollectionView.dataSource = self
    }
    
    private func setRegister() {
        rootView.homeCollectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.className)
        rootView.homeCollectionView.register(RequiredContentsCell.self, forCellWithReuseIdentifier: RequiredContentsCell.className)
        rootView.homeCollectionView.register(PopularLIVECell.self, forCellWithReuseIdentifier: PopularLIVECell.className)
        rootView.homeCollectionView.register(ParaMountPlus.self, forCellWithReuseIdentifier: ParaMountPlus.className)
        rootView.homeCollectionView.register(AdvertiseCell.self, forCellWithReuseIdentifier: AdvertiseCell.className)
        rootView.homeCollectionView.register(MagicMovieCell.self, forCellWithReuseIdentifier: MagicMovieCell.className)
        
        rootView.homeCollectionView.register(HomeViewHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeViewHeaderViewCell.className)
        rootView.homeCollectionView.register(HomeViewFooterViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeViewFooterViewCell.className)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        return section.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            fatalError("Section 오류")
        }
        
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
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewHeaderViewCell.className, for: indexPath) as? HomeViewHeaderViewCell,
                  let section = HomeSection(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
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
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewFooterViewCell.className, for: indexPath) as? HomeViewFooterViewCell,
                  let section = HomeSection(rawValue: indexPath.section), section == .main else {
                return UICollectionReusableView()
            }
            footerView.bind(input: rootView.currentBannerPage, indexPath: indexPath, pageNumber: 8)
            return footerView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.homeViewDidScroll(yOffset: scrollView.contentOffset.y)
    }
}


// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    // Implement any specific delegate methods
}
