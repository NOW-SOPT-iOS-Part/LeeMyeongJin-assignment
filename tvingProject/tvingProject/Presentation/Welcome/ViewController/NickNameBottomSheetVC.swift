//
//  NickNameBottomSheetVC.swift
//  tvingProject
//
//  Created by 이명진 on 4/13/24.
//

import UIKit

import SnapKit
import Then

protocol LoginViewControllerProtocol: AnyObject {
    func dataBind(nickName: String)
}

final class NickNameBottomSheetVC: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: LoginViewControllerProtocol?
    
    // MARK: - UIComponents
    
    private let nickName = UILabel().then {
        $0.text = "닉네임을 입력해 주세요"
        $0.font = .pretendardFont(weight: 500, size: 23)
    }
    
    private lazy var nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요 최대 (10자)"
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .gray1
        $0.addLeftPadding(width: 25)
    }
    
    private lazy var saveButton = ButtonFactory.tvingButtonFactory(title: "저장하기", backgroundColor: .gray).then {
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private var userNickName: String = ""
    
    // MARK: - Life Cycles
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setHierarchy() {
        view.addSubviews(
            nickName,
            nicknameTextField,
            saveButton
        )
    }
    
    private func setLayout() {
        nickName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nickName.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        nicknameTextField.delegate = self
    }
    
    // MARK: - @objc Function
    
    @objc
    private func saveButtonTapped() {
        delegate?.dataBind(nickName: self.userNickName)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension NickNameBottomSheetVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UITextFieldDelegate

extension NickNameBottomSheetVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .tvingRed
            
            userNickName = text
            print(userNickName)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .gray1
        }
    }
}
