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
            return UIImage(resource: .icEye)
        case .toBeReleased:
            return UIImage(resource: .icEye)
        case .search:
            return UIImage(resource: .icEye)
        case .record:
            return UIImage(resource: .icEye)
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            return UIImage(resource: .icEye)
        case .toBeReleased:
            return UIImage(resource: .icEye)
        case .search:
            return UIImage(resource: .icEye)
        case .record:
            return UIImage(resource: .icEye)
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .toBeReleased, .search, .record:
            return ViewController()
        }
    }
}
