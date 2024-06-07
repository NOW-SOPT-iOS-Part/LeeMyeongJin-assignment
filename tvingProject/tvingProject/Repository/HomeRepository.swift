//
//  HomeRepository.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import UIKit
import RxSwift

protocol MainRepositoryType {
    func getMainModels() -> Observable<[MainModel]>
    func getImageDatas() -> Observable<[Int: [UIImage]]>
    func getTitleLists() -> Observable<[String]>
}

final class HomeRepository: MainRepositoryType {
    private let service: HomeServiceType
    
    init(service: HomeServiceType) {
        self.service = service
    }
    
    func getMainModels() -> Observable<[MainModel]> {
        return service.fetchMainModels()
    }
    
    func getImageDatas() -> Observable<[Int: [UIImage]]> {
        return service.fetchImageDatas()
    }
    
    func getTitleLists() -> Observable<[String]> {
        return service.fetchTitleLists()
    }
}

