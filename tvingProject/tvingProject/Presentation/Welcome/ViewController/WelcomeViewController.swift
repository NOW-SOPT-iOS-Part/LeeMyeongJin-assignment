//
//  WelcomeViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit
import RxSwift

final class WelcomeViewController: UIViewController {
    
    // MARK: - UIComponents
    
    var coordinator: LoginCoordinator?
    private let rootView = WelcomeView()
    private let viewModel: WelcomeViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        bind()
    }
    
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        let backImage = UIImage(resource: .icLeftArrow)
        navigationController?.navigationBar.tintColor = .gray2
        
        navigationItem.leftBarButtonItem?.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.popViewController()
        }).disposed(by: disposeBag)
    }
    
    private func bind() {
        let input = WelcomeViewModel.Input(
            mainButtonTapped: rootView.mainButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.pushToLogin.subscribe { [weak self] _ in
            self?.coordinator?.showHomeViewController()
        }.disposed(by: disposeBag)
    }
    
    func setWelcomeLabel(welcomeText: String) {
        rootView.welcomeLabel.text = "\(welcomeText) 님 반갑습니다."
    }
    
    // MARK: - @objc Function
    
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
