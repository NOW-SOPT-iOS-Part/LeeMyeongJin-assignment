//
//  LoginViewModel.swift
//  tvingProject
//
//  Created by 이명진 on 5/3/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
    
    struct Input {
        let loginTextField: Observable<String>
        let passTextField: Observable<String>
    }
    
    struct Output {
        let validate: Observable<Bool>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        let emailValidationObservable = input.loginTextField
            .map { $0.range(of: self.emailRegex, options: .regularExpression) != nil }
        
        let passwordValidationObservable = input.passTextField
            .map { $0.range(of: self.passwordRegex, options: .regularExpression) != nil }
        
        let isFormValidObservable = Observable.combineLatest(
            emailValidationObservable,
            passwordValidationObservable
        ) { $0 && $1 }
        
        return Output(validate: isFormValidObservable)
    }
}
