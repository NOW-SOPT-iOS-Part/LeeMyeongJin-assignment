//
//  LoginViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/7/24.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    
    // MARK: - Property
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
    
    // MARK: - UIComponents
    
    private lazy var loginTitle = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.font = UIFont.pretendardFont(weight: 500, size: 23)
        $0.textColor = .gray1
    }
    
    private lazy var idTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "아이디",
            attributes: [
                .font: UIFont.pretendardFont(weight: 600, size: 15),
                .foregroundColor: UIColor.gray1
            ]
        )
        
        $0.addLeftPadding(width: 22)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray4
        $0.textColor = .white
        
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let passwordTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [
                .font: UIFont.pretendardFont(weight: 600, size: 15),
                .foregroundColor: UIColor.gray1
            ]
        )
        
        $0.addLeftPadding(width: 22)
        $0.isSecureTextEntry = true
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray4
        $0.textColor = .white
        
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private lazy var vStackViewLogin = UIStackView(
        arrangedSubviews: [
            idTextField,
            passwordTextField
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 7
        $0.distribution = .fillEqually
    }
    
    private lazy var loginButton = UIButton().then {
        $0.setTitle("로그인 하기", for: .normal)
        $0.titleLabel?.font = .pretendardFont(weight: 600, size: 14)
        // 버튼 기본 배경색 설정
        $0.backgroundColor = .clear
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4.cgColor
        $0.layer.cornerRadius = 3
        $0.addTarget(self, action: #selector(pushToLoginSuccess), for: .touchUpInside)
        
        $0.isEnabled = false
    }
    
    private let idSearch = UILabel().then {
        $0.text = "아이디 찾기"
        $0.font = .pretendardFont(weight: 600, size: 14)
        $0.textColor = .gray2
    }
    
    private let dividerLabel = UILabel().then {
        $0.text = "|"
        $0.textColor = .gray4
    }
    
    private let passwordSearch = UILabel().then {
        $0.text = "비밀번호 찾기"
        $0.font = .pretendardFont(weight: 600, size: 14)
        $0.textColor = .gray2
    }
    
    private lazy var allDeleteButton = UIButton().then {
        $0.setImage(UIImage(resource: .icCancel), for: .normal)
        $0.tintColor = .white
        $0.isHidden = true
        $0.addTarget(self, action: #selector(deletePasswordTapped), for: .touchUpInside)
    }
    
    private lazy var togglePasswordButton = UIButton().then {
        $0.setImage(UIImage(resource: .icEyeSlash), for: .normal)
        $0.isHidden = true
        
        $0.addTarget(self, action: #selector(togglePasswordTapped), for: .touchDown)
        
    }
    
    private lazy var hStackViewInfoFirst = UIStackView(
        arrangedSubviews: [
            idSearch,
            dividerLabel,
            passwordSearch
        ]
    ).then {
        $0.spacing = 36
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private let notAccountLabel = UILabel().then {
        $0.text = "아직 계정이 없으신가요?"
        $0.font = .pretendardFont(weight: 600, size: 14)
        $0.textColor = .gray3
    }
    
    private let makeNickNameLabel = UILabel().then {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.gray2,
            .font: UIFont.pretendardFont(weight: 400, size: 14)
        ]
        
        $0.attributedText = NSAttributedString(
            string: "TVING ID 회원가입하기",
            attributes: attributes
        )
    }
    
    private lazy var hStackViewInfoSecond = UIStackView(
        arrangedSubviews: [
            notAccountLabel,
            makeNickNameLabel
        ]
    ).then {
        $0.spacing = 8
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setHierarchy() {
        self.view.addSubviews(
            loginTitle,
            vStackViewLogin,
            allDeleteButton,
            togglePasswordButton,
            loginButton,
            hStackViewInfoFirst,
            hStackViewInfoSecond
        )
    }
    
    private func setLayout() {
        
        loginTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(4)
        }
        
        vStackViewLogin.snp.makeConstraints {
            $0.top.equalTo(self.loginTitle.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52 + 52 + 7)
        }
        
        allDeleteButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.top).offset(16)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(56)
        }
        
        togglePasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.top).offset(16)
            $0.leading.equalTo(allDeleteButton.snp.trailing).offset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(vStackViewLogin.snp.bottom).offset(21)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        hStackViewInfoFirst.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.height.equalTo(22)
            $0.leading.trailing.equalToSuperview().inset(85)
        }
        
        hStackViewInfoSecond.snp.makeConstraints {
            $0.top.equalTo(hStackViewInfoFirst.snp.bottom).offset(31)
            $0.height.equalTo(22)
            $0.leading.trailing.equalToSuperview().inset(51)
        }
    }
    
    private func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    // MARK: - @objc
    
    @objc
    private func pushToLoginSuccess() {
        let welcomeViewController = WelcomeViewController()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    @objc
    private func togglePasswordTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        
        if passwordTextField.isSecureTextEntry {
            togglePasswordButton.setImage(UIImage(resource: .icEyeSlash), for: .normal)
        } else {
            togglePasswordButton.setImage(UIImage(resource: .icEye), for: .normal)  // Assuming .icEye is the icon for visible password
        }
    }
    
    @objc
    private func deletePasswordTapped() {
        passwordTextField.text = ""
        updateButtonVisibility()
    }
    
    // MARK: - Methods
    
    private func updateButtonVisibility() {
        let isPasswordFieldEmpty = passwordTextField.text?.isEmpty ?? true
        allDeleteButton.isHidden = isPasswordFieldEmpty
        togglePasswordButton.isHidden = isPasswordFieldEmpty
        
        updateButtonStyle(button: self.loginButton, enabled: !isPasswordFieldEmpty)
    }
    
    
    private func validateAndToggleLoginButton() {
        let isEmailValid = isValidEmail(idTextField.text)
        let isPasswordValid = isValidPassword(passwordTextField.text)
        
        let isFormValid = isEmailValid && isPasswordValid
        loginButton.isEnabled = isFormValid
        
        updateButtonStyle(button: self.loginButton, enabled: isFormValid)
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
        if enabled {
            button.backgroundColor = .tvingRed
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .clear
            button.setTitleColor(.gray2, for: .normal)
        }
    }
    
}




// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validateAndToggleLoginButton()
        
        if textField == passwordTextField {
            if let text = textField.text, text.isEmpty {
                allDeleteButton.isHidden = true
                togglePasswordButton.isHidden = true
            } else {
                allDeleteButton.isHidden = false
                togglePasswordButton.isHidden = false
            }
        }
    }
    
}



/*
 #D6D6D6 gray1
 #9C9C9C gray2
 #626262 gray3
 #2E2E2E gray4
 #191919 gray5
 */
