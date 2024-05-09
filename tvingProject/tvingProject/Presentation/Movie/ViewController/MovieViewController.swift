//
//  MovieViewController.swift
//  tvingProject
//
//  Created by 이명진 on 5/8/24.
//

import UIKit

final class MovieViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let rootView = MovieView()
    private var movies: [DailyBoxOfficeList] = []
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setRegister()
        fetchData()
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
        rootView.movieCollectionView.dataSource = self
    }
    
    private func setRegister() {
        rootView.movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.className)
    }
    
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.className, for: indexPath) as? MovieCell
        else { return UICollectionViewCell() }
        
        let model = self.movies[indexPath.row]
        let changeFormat = Formatter.formatNumberKoreanStyle(model.audiAcc)
        
        cell.bind(rank: model.rank, movieName: model.movieNm, date: "개봉일: \(model.openDt)", accAudience: "누적 관객수: \(changeFormat ?? "")")
        return cell
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.rootView.movieCollectionView.frame.width / 3 + 50,
                      height: self.rootView.movieCollectionView.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    }
}

extension MovieViewController {
    private func fetchData() {
        MovieService.shared.fetctMovieChart(date: "20240508") { [weak self] response in
            switch response {
            case.success(let data):
                guard let data = data as? MovieModel else { return }
                self?.movies.append(contentsOf: data.boxOfficeResult.dailyBoxOfficeList)
                self?.rootView.movieCollectionView.reloadData()
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
}
