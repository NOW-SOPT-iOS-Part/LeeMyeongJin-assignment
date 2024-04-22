//
//  UIVIewController+.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

extension UIViewController {
    
    /// 뷰 컨트롤러가 네비게이션 스택에 있으면 pop 하고, 나머지는  dismiss 합니다.
    func popOrDismissViewController(animated: Bool = true) {
        if let navigationController = self.navigationController, navigationController.viewControllers.contains(self) {
            navigationController.popViewController(animated: animated)
        } else if self.presentingViewController != nil {
            self.dismiss(animated: animated)
        }
    }
}
