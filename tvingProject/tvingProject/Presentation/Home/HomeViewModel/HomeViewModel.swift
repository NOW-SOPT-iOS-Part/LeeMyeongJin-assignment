//
//  HomeViewModel.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

struct mainModel {
    var image: UIImage
    var title: String
    var info: String
    
    static func getData() -> [mainModel] {
        return [
            mainModel(
                image: UIImage(resource: .mainImage7),
                title: "지켜보고 있다",
                info: "곧 개무서운 영화가 온다"
            ),
            mainModel(
                image: UIImage(resource: .mainImage8),
                title: "마녀 사냥",
                info: "신동엽의 19금 토크쇼 이제 시작."
            ),
            mainModel(
                image: UIImage(resource: .mainImage3),
                title: "시그널",
                info: "조진웅 김혜수 이재훈 오지는 조합!"
            ), 
            mainModel(
                image: UIImage(resource: .mainImage3),
                title: "시그널",
                info: "조진웅 김혜수 이재훈 오지는 조합!"
            ),
            mainModel(
                image: UIImage(resource: .mainImage3),
                title: "시그널",
                info: "조진웅 김혜수 이재훈 오지는 조합!"
            )
        ]
    }
}
