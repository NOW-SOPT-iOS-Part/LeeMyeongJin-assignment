//
//  ButtonFactory.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

import Then

struct ButtonFactory {
    static func tvingButtonFactory(
        title: String,
        backgroundColor: UIColor = .clear,
        radius: CGFloat = 12
    ) -> UIButton {
        return UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.font = .pretendardFont(weight: 600, size: 14)
            $0.backgroundColor = backgroundColor
            $0.layer.cornerRadius = radius
            $0.isEnabled = false
            $0.setTitleColor(.white, for: .selected)
        }
    }
}
