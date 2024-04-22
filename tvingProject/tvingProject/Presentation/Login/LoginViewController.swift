//
//  LoginViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Property
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
    
    var userNickName: String = ""
    
    private var passwordVisibility: PasswordVisibility = .hidden
    
    // MARK: - UIComponents
    
    private let rootView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setAddTarget()
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
    
    private func validateAndToggleLoginButton() {
        let isEmailValid = isValidEmail(rootView.idTextField.text)
        let isPasswordValid = isValidPassword(rootView.passwordTextField.text)
        let isFormValid = isEmailValid && isPasswordValid
        
        updateButtonStyle(button: rootView.loginButton, enabled: isFormValid)
    }
    
    private func isValidEmail(_ string: String?) -> Bool {
        guard let string = string else { return false }
        
        return string.range(of: self.emailRegex, options: .regularExpression) != nil
    }
    
    private func isValidPassword(_ string: String?) -> Bool {
        guard let string = string else { return false }
        
        return string.range(of: self.passwordRegex, options: .regularExpression) != nil
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
        validateAndToggleLoginButton()
        
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

