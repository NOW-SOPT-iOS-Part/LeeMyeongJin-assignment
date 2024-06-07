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
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
    
    struct Input {
        let loginTextField: Observable<String>
        let passwordTextField: Observable<String>
        let loginButtonTapped: Observable<Void>
        let nickNameLabelTapped: Observable<Void>
        let deletePasswordTapped: Observable<Void>
        let togglePasswordTapped: Observable<Void>
    }
    
    struct Output {
        let validate: Observable<Bool>
        let loginSuccess: Observable<Void>
        let presentNicknameBottomSheet: Observable<Void>
        let deletePasswordTappedEvent: Observable<Void>
        let togglePasswordTappedEvent: Observable<Void>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        let emailValidationObservable = input.loginTextField
            .map { $0.range(of: self.emailRegex, options: .regularExpression) != nil }
        
        let passwordValidationObservable = input.passwordTextField
            .map { $0.range(of: self.passwordRegex, options: .regularExpression) != nil }
        
        let isFormValidObservable = Observable.combineLatest(emailValidationObservable, passwordValidationObservable) {
            $0 && $1
        }
        
        let loginSuccessObservable = input.loginButtonTapped
            .withLatestFrom(isFormValidObservable)
            .filter { $0 }
            .map { _ in }
        
        let nickNameLabeTapped = input.nickNameLabelTapped
            .map { _ in }
        
        let deletePasswordTapped = input.deletePasswordTapped
            .map { _ in }
        
        let togglePasswordTapped = input.togglePasswordTapped
            .map { _ in }
        
        return Output(
            validate: isFormValidObservable,
            loginSuccess: loginSuccessObservable,
            presentNicknameBottomSheet: nickNameLabeTapped,
            deletePasswordTappedEvent: deletePasswordTapped,
            togglePasswordTappedEvent: togglePasswordTapped
        )
    }
}
