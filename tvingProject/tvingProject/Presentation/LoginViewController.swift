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
    }
    
    private lazy var loginbutton = UIButton().then {
        $0.setTitle("로그인 하기", for: .normal)
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray4.cgColor
        $0.addTarget(self, action: #selector(pushToLoginSuccess), for: .touchUpInside)
    }
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            idTextField,
            passwordTextField
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 7
        $0.distribution = .fillEqually
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
        $0.text = "아직 게정이 없으신가요?"
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
    
    /*
     #D6D6D6 gray1
     #9C9C9C gray2
     #626262 gray3
     #2E2E2E gray4
     #191919 gray5
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setHierarchy() {
        self.view.addSubviews(
            loginTitle,
            vStackView,
            loginbutton,
            hStackViewInfoFirst,
            hStackViewInfoSecond
        )
    }
    
    private func setLayout() {
        
        loginTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(4)
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(self.loginTitle.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52 + 52 + 7)
        }
        
        loginbutton.snp.makeConstraints {
            $0.top.equalTo(vStackView.snp.bottom).offset(21)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        hStackViewInfoFirst.snp.makeConstraints {
            $0.top.equalTo(loginbutton.snp.bottom).offset(31)
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
        
    }
    
    private func setRegister() {
        
    }
    
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
