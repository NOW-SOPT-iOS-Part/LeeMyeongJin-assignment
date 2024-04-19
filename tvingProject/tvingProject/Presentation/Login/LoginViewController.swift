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
    
    // MARK: - UIComponents
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = loginView
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
            welcomeViewController.setWelcomeLabel(welcomeText: loginView.idTextField.text ?? "")
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
    
    
    @objc
    private func togglePasswordTapped() {
        loginView.passwordTextField.isSecureTextEntry.toggle()
        
        let isSecure = loginView.passwordTextField.isSecureTextEntry
        
        if isSecure {
            loginView.togglePasswordButton.setImage(UIImage(resource: .icEyeSlash), for: .normal)
        } else {
            loginView.togglePasswordButton.setImage(UIImage(resource: .icEye), for: .normal)
        }
    }
    
    @objc
    private func deletePasswordTapped() {
        loginView.passwordTextField.text = ""
        updateButtonEnable()
    }
    
    // MARK: - Methods
    
    private func updateButtonEnable() {
        let isPasswordFieldEmpty = loginView.passwordTextField.text?.isEmpty ?? true
        loginView.allDeleteButton.isHidden = isPasswordFieldEmpty
        loginView.togglePasswordButton.isHidden = isPasswordFieldEmpty
        
        updateButtonStyle(button: loginView.loginButton, enabled: !isPasswordFieldEmpty)
    }
    
    private func validateAndToggleLoginButton() {
        let isEmailValid = isValidEmail(loginView.idTextField.text)
        let isPasswordValid = isValidPassword(loginView.passwordTextField.text)
        let isFormValid = isEmailValid && isPasswordValid
        
        updateButtonStyle(button: loginView.loginButton, enabled: isFormValid)
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
        
        loginView.loginButton.isEnabled = enabled
        
        if enabled {
            button.backgroundColor = .tvingRed
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .clear
            button.setTitleColor(.gray2, for: .normal)
        }
    }
    
    private func setAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(pushToLoginSuccess), for: .touchUpInside)
        loginView.allDeleteButton.addTarget(self, action: #selector(deletePasswordTapped), for: .touchUpInside)
        loginView.togglePasswordButton.addTarget(self, action: #selector(togglePasswordTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentToNicknameBottomSheet))
        loginView.makeNickNameLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setDelegate() {
        loginView.idTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validateAndToggleLoginButton()
        
        if textField == loginView.passwordTextField {
            if let text = textField.text, text.isEmpty {
                loginView.allDeleteButton.isHidden = true
                loginView.togglePasswordButton.isHidden = true
            } else {
                loginView.allDeleteButton.isHidden = false
                loginView.togglePasswordButton.isHidden = false
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

