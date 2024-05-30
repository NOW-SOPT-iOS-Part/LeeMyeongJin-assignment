//
//  ViewModelType.swift
//  tvingProject
//
//  Created by 이명진 on 5/3/24.
//

import Combine
import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input, disposeBag: DisposeBag) -> Output
}
