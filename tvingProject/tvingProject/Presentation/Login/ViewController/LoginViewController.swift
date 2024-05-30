//
//  LoginViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    // MARK: - Property
    
    var userNickName: String = ""
    
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
        setAddTarget()
        bind()
    }
    
    
    // MARK: - Bind
    
    private func bind() {
        let input = LoginViewModel.Input(
            loginTextField: rootView.idTextField.rx.text.orEmpty.asObservable(),
            passTextField: rootView.passwordTextField.rx.text.orEmpty.asObservable()
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.validate
            .subscribe(with: self, onNext: { [weak self] owner, isvalid in
                self?.updateButtonStyle(button: owner.rootView.loginButton, enabled: isvalid)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - @objc Function
    
    @objc
    private func pushToLoginSuccess() {
        let welcomeViewController = WelcomeViewController()
        
        if self.userNickName.isEmpty {
            welcomeViewController.setWelcomeLabel(welcomeText: rootView.idTextField.text ?? "")
        } else {
            welcomeViewController.setWelcomeLabel(welcomeText: self.userNickName)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    @objc
    private func presentToNicknameBottomSheet() {
        let nicknameBottomSheet = NickNameBottomSheetVC()
        nicknameBottomSheet.delegate = self
        self.present(nicknameBottomSheet, animated: true)
    }
    
    
    @objc private func togglePasswordTapped() {
        passwordVisibility.toggle()
        rootView.passwordTextField.isSecureTextEntry = (passwordVisibility == .hidden)
        rootView.togglePasswordButton.setImage(passwordVisibility.icon, for: .normal)
    }
    
    @objc
    private func deletePasswordTapped() {
        rootView.passwordTextField.text = ""
        updateButtonEnable()
    }
    
    // MARK: - Methods
    
    private func updateButtonEnable() {
        let isPasswordFieldEmpty = rootView.passwordTextField.text?.isEmpty ?? true
        rootView.allDeleteButton.isHidden = isPasswordFieldEmpty
        rootView.togglePasswordButton.isHidden = isPasswordFieldEmpty
        
        updateButtonStyle(button: rootView.loginButton, enabled: !isPasswordFieldEmpty)
    }
    
    private func updateButtonStyle(button: UIButton, enabled: Bool) {
        let style = enabled ? ButtonStyle.enabled : ButtonStyle.disabled
        
        button.isEnabled = enabled
        button.backgroundColor = style.backgroundColor
        button.setTitleColor(style.titleColor, for: .normal)
    }
    
    private func setAddTarget() {
        rootView.loginButton.addTarget(self, action: #selector(pushToLoginSuccess), for: .touchUpInside)
        rootView.allDeleteButton.addTarget(self, action: #selector(deletePasswordTapped), for: .touchUpInside)
        rootView.togglePasswordButton.addTarget(self, action: #selector(togglePasswordTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentToNicknameBottomSheet))
        rootView.makeNickNameLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setDelegate() {
        rootView.idTextField.delegate = self
        rootView.passwordTextField.delegate = self
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //        validateAndToggleLoginButton()
        
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

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .black
        }
        
        set {
            setTitleColor(newValue ? .white: .gray2, for: .normal)
            backgroundColor = newValue ? .tvingRed : .clear
            isEnabled = newValue
        }
    }
}
