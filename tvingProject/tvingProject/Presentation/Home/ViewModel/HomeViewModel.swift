//
//  HomeViewModel.swift
//  tvingProject
//
//  Created by 이명진 on 6/7/24.
//

import UIKit

import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let mainModels: Driver<[MainModel]>
        let imageDatas: Driver<[Int: [UIImage]]>
        let titleLists: Driver<[String]>
        let error: Driver<String>
    }
    
    private let repository: HomeRepositoryType
    private let disposeBag = DisposeBag()
    
    init(repository: HomeRepositoryType) {
        self.repository = repository
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let errorSubject = PublishSubject<String>()
        
        let mainModels = input.viewDidLoad
            .flatMapLatest { [repository] _ in
                repository.getMainModels()
                    .catch { error in
                        errorSubject.onNext(error.localizedDescription)
                        return Observable.just([])
                    }
            }
            .asDriver(onErrorJustReturn: [])
        
        let imageDatas = input.viewDidLoad
            .flatMapLatest { [repository] _ in
                repository.getImageDatas()
                    .catch { error in
                        errorSubject.onNext(error.localizedDescription)
                        return Observable.just([:])
                    }
            }
            .asDriver(onErrorJustReturn: [:])
        
        let titleLists = input.viewDidLoad
            .flatMapLatest { [repository] _ in
                repository.getTitleLists()
                    .catch { error in
                        errorSubject.onNext(error.localizedDescription)
                        return Observable.just([])
                    }
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(
            mainModels: mainModels,
            imageDatas: imageDatas,
            titleLists: titleLists,
            error: errorSubject.asDriver(onErrorJustReturn: "error")
        )
    }
}

