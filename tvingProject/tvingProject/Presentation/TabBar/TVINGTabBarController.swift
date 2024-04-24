//
//  TVINGTabBarController.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import Then

final class TVINGTabBarController: UITabBarController {
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTabBarController()
    }
    
    private func setUI() {
        tabBar.do {
            $0.backgroundColor = .black
            $0.unselectedItemTintColor = .gray3
            $0.tintColor = .white
            $0.barTintColor = .black
        }
    }
    
    private func setTabBarController() {
        let tabBarItems: [TVINGTabBarItem] = [
            .home,
            .toBeReleased,
            .search,
            .record
        ]
        
        viewControllers = tabBarItems.map { item in
            return templateNavigationController(
                title: item.title,
                unSelectedImage: item.unSelectedImage,
                selectedImage: item.selectedImage,
                rootViewController: item.viewController
            )
        }
    }
    
    private func templateNavigationController(
        title: String,
        unSelectedImage: UIImage,
        selectedImage: UIImage,
        rootViewController: UIViewController
    ) -> UINavigationController {
        
        return UINavigationController(rootViewController: rootViewController).then {
            $0.title = title
            $0.tabBarItem.image = unSelectedImage
            $0.tabBarItem.selectedImage = selectedImage
            $0.navigationBar.isHidden = true
        }
    }
    
}
