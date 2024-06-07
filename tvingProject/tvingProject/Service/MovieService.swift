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
    
    
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self) 애서 디코딩 오류가 발생했습니다")
            return .pathErr
        }
        
        return .success(decodedData as Any)
    }
}
