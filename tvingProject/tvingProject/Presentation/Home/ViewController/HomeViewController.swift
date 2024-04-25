//
//  HomeViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import Then

enum HomeSection: Int, CaseIterable {
    case main = 0
    case required
    case popular
    case paraMount
    case advertise
    case magicMovie
    
    
    var identifier: String {
        switch self {
        case .main:
            return MainCell.className
        case .required:
            return RequiredContentsCell.className
        case .popular:
            return PopularLIVECell.className
        case .paraMount:
            return ParaMountPlus.className
        case .advertise:
            return AdvertiseCell.className
        case .magicMovie:
            return MagicMovieCell.className
        }
    }
    
}

final class HomeViewController: UIViewController {
    
    
    // MARK: - Property
    weak var scrollDelegate: HomeViewScrollDelegate?
    
    private let titleLists: [String] = ["티빙에서 꼭 봐야하는 컨텐츠", "인기 LIVE 채널", "1화 무료! 파라마운트+ 인기 시리즈", "마술보다 더 신비로운 영화(신비로운 영화사전님)"]
    
    private let imagesBySection: [Int: [UIImage]] = [
        0: [UIImage(resource: .mainImage1), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2)],
        1: [UIImage(resource: .mainImage2), UIImage(resource: .mainImage4), UIImage(resource: .mainImage5), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1)],
        2: [UIImage(resource: .mainImage4), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage1)],
        3: [UIImage(resource: .mainImage4), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage1)],
        4: [UIImage(resource: .mainImage4), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage1)],
        5: [UIImage(resource: .mainImage4), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage1)]
    ]
    
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
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeSection(rawValue: indexPath.section)!
        let identifier = section.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        // 이미지 바인딩
         if let imageCell = cell as? ImageBindable, let sectionImages = imagesBySection[indexPath.section], indexPath.item < sectionImages.count {
             imageCell.bindData(image: sectionImages[indexPath.item])
         }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewHeaderViewCell.className, for: indexPath) as? HomeViewHeaderViewCell else {
            
            return UICollectionReusableView()
        }
        
        switch indexPath.section {
        case 1:
            headerView.bindTitle(title: titleLists[0])
        case 2:
            headerView.bindTitle(title: titleLists[1])
        case 3:
            headerView.bindTitle(title: titleLists[2])
        case 5:
            headerView.bindTitle(title: titleLists[3])
        default:
            headerView.bindTitle(title: "")
        }
        
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.homeViewDidScroll(yOffset: scrollView.contentOffset.y)
    }
}




// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    // Implement any specific delegate methods you might need
}


//// MARK: - Preview
//
//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//    
//    func makeUIViewController(context: Context) -> UIViewController {
//        // 이부분
//        TVINGTabBarController()
//        // 이거 보고싶은 현재 VC로 바꾸면됩니다.
//    }
//    
//    func updateUIViewController(_ uiView: UIViewController, context: Context) {
//        // leave this empty
//    }
//}
//
//struct ViewController_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Preview()
//                .edgesIgnoringSafeArea(.all)
//                .previewDisplayName("Preview")
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
//        }
//    }
//}
//#endif
