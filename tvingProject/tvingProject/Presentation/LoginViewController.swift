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
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4.cgColor
        $0.layer.cornerRadius = 3
        $0.addTarget(self, action: #selector(pushToLoginSuccess), for: .touchUpInside)
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
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setHierarchy() {
        self.view.addSubviews(
            loginTitle,
            vStackViewLogin,
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
}


/*
 #D6D6D6 gray1
 #9C9C9C gray2
 #626262 gray3
 #2E2E2E gray4
 #191919 gray5
 */
