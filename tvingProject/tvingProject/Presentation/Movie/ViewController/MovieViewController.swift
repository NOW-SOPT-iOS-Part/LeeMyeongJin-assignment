//
//  MovieViewController.swift
//  tvingProject
//
//  Created by 이명진 on 5/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let rootView = MovieView()
    private var viewModel: MovieViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setRegister()
        setDelegate()
        bindViewModel()
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setDelegate() {
        rootView.movieCollectionView.delegate = self
    }
    
    private func setRegister() {
        rootView.movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.className)
    }
    
    private func bindViewModel() {
        let input = MovieViewModel.Input(fetchMovies: Observable.just(()))
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.movies
            .drive(rootView.movieCollectionView.rx.items(cellIdentifier: MovieCell.className, cellType: MovieCell.self)) { _, model, cell in
                cell.bind(model: model)
            }
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] errorMessage in
                self?.showErrorAlert(message: errorMessage)
            })
            .disposed(by: disposeBag)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding * 3
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
