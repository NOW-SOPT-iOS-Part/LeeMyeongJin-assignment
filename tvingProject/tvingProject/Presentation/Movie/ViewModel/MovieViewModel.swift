//
//  MovieViewModel.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieViewModel: ViewModelType {
    
    struct Input {
        let fetchMovies: Observable<Void>
    }
    
    struct Output {
        let movies: Driver<[DailyBoxOfficeList]>
        let error: Driver<String>
    }
    
    private let movieService: MovieServiceType
    private let disposeBag = DisposeBag()
    
    init(movieService: MovieServiceType) {
        self.movieService = movieService
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let errorTracker = PublishSubject<String>()
        
        let movies = input.fetchMovies
            .flatMapLatest { [weak self] _ -> Observable<[DailyBoxOfficeList]> in
                guard let self = self else { return Observable.just([]) }
                
                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                
                guard let formattedDate = yesterday.map(dateFormatter.string(from:)) else {
                    errorTracker.onNext("날짜 형식 오류")
                    return Observable.just([])
                }
                
                return self.movieService.fetchMovieChart(date: formattedDate)
                    .catch { error in
                        errorTracker.onNext("영화 데이터를 불러오는데 실패했습니다.")
                        return Observable.just([])
                    }
            }
            .share(replay: 1)
        
        return Output(
            movies: movies.asDriver(onErrorJustReturn: []),
            error: errorTracker.asDriver(onErrorJustReturn: "")
        )
    }
}

