//
//  CompositionalLayout.swift
//  tvingProject
//
//  Created by 이명진 on 4/24/24.
//

import UIKit
import Combine

struct CompositionalLayout {
    
    static func createLayout(currentBannerPage: PassthroughSubject<Int, Never>) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(498)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .paging
                
                section.visibleItemsInvalidationHandler = { (visibleItems, offset, env) in
                    let currentPage = Int(max(0, round(offset.x / env.container.contentSize.width)))
                    currentBannerPage.send(currentPage)
                }
                
                // footer 추가
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
                let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: footerSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottomLeading,
                    absoluteOffset: CGPoint(x: -140, y: 16)  // 여기에서 Y 값을 조정하여 위나 아래로 옮길 수 있습니다.
                )
                
                section.boundarySupplementaryItems = [footerSupplementary]
                
                return section
                
            } else if sectionNumber == 1 || sectionNumber == 5 {
                
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(146)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                item.contentInsets.trailing = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(140)), subitems: [item])
                
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if sectionNumber == 3 {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                item.contentInsets.leading = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(164)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
                
            } else if sectionNumber == 4 { // 광고
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                item.contentInsets.trailing = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(58)), subitems: [item])
                
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.top = 48
                
                return section
            } else {
                
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets.bottom = 44
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(498)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .paging
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            }
        }
    }
    
}
