//
//  TVINGTabBarItem.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

enum TVINGTabBarItem {
    case home
    case toBeReleased
    case search
    case record
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .toBeReleased:
            return "공개예정"
        case .search:
            return "검색"
        case .record:
            return "기록"
        }
    }
    
    var unSelectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .toBeReleased:
            return UIImage(systemName: "video.square")!
        case .search:
            return UIImage(resource: .icSearch)
        case .record:
            return UIImage(systemName: "clock")!
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .toBeReleased:
            return UIImage(systemName: "video.square.fill")!
        case .search:
            return UIImage(resource: .icSearchFill)
        case .record:
            return UIImage(systemName: "clock.fill")!
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return CenterViewController()
        case .toBeReleased, .search, .record:
            return ViewController()
        }
    }
}
