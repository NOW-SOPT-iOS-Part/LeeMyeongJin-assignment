//
//  UITextField+Combine.swift
//  tvingProject
//
//  Created by 이명진 on 5/3/24.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .compactMap { $0 }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }
}

