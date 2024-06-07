//
//  HomeService.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import UIKit
import RxSwift

protocol HomeServiceType {
    func fetchMainModels() -> Observable<[MainModel]>
    func fetchImageDatas() -> Observable<[Int: [UIImage]]>
    func fetchTitleLists() -> Observable<[String]>
}

final class HomeService: HomeServiceType {
    func fetchMainModels() -> Observable<[MainModel]> {
        return Observable.just(MainModel.getData())
    }
    
    func fetchImageDatas() -> Observable<[Int: [UIImage]]> {
        return Observable.just(MainModel.getImageDatas())
    }
    
    func fetchTitleLists() -> Observable<[String]> {
        return Observable.just(MainModel.getTitleLists())
    }
}

