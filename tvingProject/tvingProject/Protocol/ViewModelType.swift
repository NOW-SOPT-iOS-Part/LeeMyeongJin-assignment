//
//  ViewModelType.swift
//  tvingProject
//
//  Created by 이명진 on 5/3/24.
//

import Combine

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
