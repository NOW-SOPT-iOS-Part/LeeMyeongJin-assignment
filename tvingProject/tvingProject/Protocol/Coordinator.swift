//
//  Coordinator.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

