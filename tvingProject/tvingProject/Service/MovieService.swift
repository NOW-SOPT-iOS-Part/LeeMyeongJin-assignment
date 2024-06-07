//
//  MovieService.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import Foundation
import Moya
import RxSwift
import RxMoya

protocol MovieServiceType {
    func fetchMovieChart(date: String) -> Observable<[DailyBoxOfficeList]>
}

final class MovieService: MovieServiceType {
    
    private var movieProvider = MoyaProvider<MovieTargetType>(plugins: [MoyaLoggingPlugin()])
    
    func fetchMovieChart(date: String) -> Observable<[DailyBoxOfficeList]> {
        return movieProvider.rx.request(.getMovieInfo(date: date))
            .filterSuccessfulStatusCodes()
            .map(MovieModel.self)
            .map { $0.boxOfficeResult.dailyBoxOfficeList }
            .asObservable()
            .catch { error in
                print("⛔️ 서버 통신 오류: \(error)")
                return Observable.just([])
            }
    }
}
