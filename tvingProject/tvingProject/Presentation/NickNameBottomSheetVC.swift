//
//  NickNameBottomSheetVC.swift
//  tvingProject
//
//  Created by 이명진 on 4/13/24.
//

import UIKit

import SnapKit
import Then

final class NickNameBottomSheetVC: UIViewController {
    
    
    // MARK: - Property
    
    private let nickName = UILabel().then {
        $0.text = "닉네임을 입력해 주세요"
    }
    
    private lazy var nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요 최대 (10자)"
    }
    
    private lazy var saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.titleLabel?.font = .pretendardFont(weight: 600, size: 14)
    }
    
    // MARK: - UIComponents
    
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
    }
    
    func setData(nickName: String) {
        self.nickName.text = nickName
    }
    
}

extension NickNameBottomSheetVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
