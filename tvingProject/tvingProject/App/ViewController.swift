//
//  ViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - UIComponents
    
    // MARK: - Life Cycles
    
    init(_ backgroundColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUI()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .darkGray
    }
    
}
