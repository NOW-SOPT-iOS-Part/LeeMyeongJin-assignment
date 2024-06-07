//
//  WelcomeViewModel.swift
//  tvingProject
//
//  Created by 이명진 on 5/31/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WelcomeViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let mainButtonTapped: Observable<Void>
    }
    
    struct Output {
        let pushToLogin: Observable<Void>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        let loginSuccessObservable = input.mainButtonTapped.asObservable()
            .map { _ in }
        
        return Output(pushToLogin: loginSuccessObservable)
    }
}

