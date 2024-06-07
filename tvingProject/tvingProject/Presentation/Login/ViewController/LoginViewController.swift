//
//  LoginViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class LoginViewController: UIViewController {
    
    // MARK: - Property
    
    var coordinator: LoginCoordinator?
    private var userNickName: String = ""
    
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    private var passwordVisibility: PasswordVisibility = .hidden
    
    // MARK: - UIComponents
    
    private let rootView = LoginView()
    
    // MARK: - Life Cycles
    
    init(viewModel: LoginViewModel) { // 의존성 주입
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        let input = LoginViewModel.Input(
            loginTextField: rootView.idTextField.rx.text.orEmpty.asObservable(),
            passwordTextField: rootView.passwordTextField.rx.text.orEmpty.asObservable(),
            loginButtonTapped: rootView.loginButton.rx.tap.asObservable(),
            nickNameLabelTapped: rootView.makeNickNameLabel.rx.tapGesture().when(.recognized).map { _ in },
            deletePasswordTapped: rootView.allDeleteButton.rx.tap.asObservable(),
            togglePasswordTapped: rootView.togglePasswordButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.validate
            .map { $0 ? ButtonStyle.enabled : ButtonStyle.disabled }
            .subscribe(onNext: { [weak self] style in
                self?.updateButtonStyle(button: self?.rootView.loginButton, style: style)
            })
            .disposed(by: disposeBag)
        
        output.loginSuccess
            .subscribe { [weak self] _ in
                self?.loginSuccess()
            }.disposed(by: disposeBag)
        
        output.presentNicknameBottomSheet
            .subscribe { [weak self] _ in
                self?.presentToNicknameBottomSheet()
            }.disposed(by: disposeBag)
        
        output.deletePasswordTappedEvent
            .subscribe { [weak self] _ in
                self?.deletePasswordTapped()
            }.disposed(by: disposeBag)
        
        output.togglePasswordTappedEvent
            .subscribe { [weak self] _ in
                self?.togglePasswordTapped()
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func updateButtonEnable() {
        let isPasswordFieldEmpty = rootView.passwordTextField.text?.isEmpty ?? true
        rootView.allDeleteButton.isHidden = isPasswordFieldEmpty
        rootView.togglePasswordButton.isHidden = isPasswordFieldEmpty
        
        updateButtonStyle(button: rootView.loginButton, style: isPasswordFieldEmpty ? .disabled : .enabled)
    }
    
    private func updateButtonStyle(button: UIButton?, style: ButtonStyle) {
        guard let button = button else { return }
        button.isEnabled = (style == .enabled)
        button.backgroundColor = style.backgroundColor
        button.setTitleColor(style.titleColor, for: .normal)
    }
    
    private func loginSuccess() {
        self.userNickName.isEmpty ?
            coordinator?.showWelcomeViewController(nickname: rootView.idTextField.text ?? "") :
            coordinator?.showWelcomeViewController(nickname: self.userNickName)
    }
    
    private func presentToNicknameBottomSheet() {
        let nicknameBottomSheet = NickNameBottomSheetVC()
        nicknameBottomSheet.delegate = self
        self.present(nicknameBottomSheet, animated: true)
    }
    
    private func deletePasswordTapped() {
        rootView.passwordTextField.text = ""
        updateButtonEnable()
    }
    
    private func togglePasswordTapped() {
        passwordVisibility.toggle()
        rootView.passwordTextField.isSecureTextEntry = (passwordVisibility == .hidden)
        rootView.togglePasswordButton.setImage(passwordVisibility.icon, for: .normal)
    }
    
    private func setDelegate() {
        rootView.idTextField.delegate = self
        rootView.passwordTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == rootView.passwordTextField {
            if let text = textField.text, text.isEmpty {
                rootView.allDeleteButton.isHidden = true
                rootView.togglePasswordButton.isHidden = true
            } else {
                rootView.allDeleteButton.isHidden = false
                rootView.togglePasswordButton.isHidden = false
            }
        }
    }
    
    // 해당 텍스트 필드 강조 코드
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
    }
    
    // 텍스트 필드 사용 끝나면
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.layer.borderColor = nil
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func dataBind(nickName: String) {
        print("LoginViewController의 userNickName에 \(nickName)이 대입 됌")
        self.userNickName = nickName
    }
}
