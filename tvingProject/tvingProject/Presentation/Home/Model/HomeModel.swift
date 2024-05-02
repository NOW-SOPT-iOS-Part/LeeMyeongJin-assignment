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
                info: "조진웅 김혜수 이재훈 지리는 조합!"
            ),
            mainModel(
                image: UIImage(resource: .mainImage3),
                title: "시그널",
                info: "조진웅 김혜수 이재훈 개쩌는 조합!"
            ),
            mainModel(
                image: UIImage(resource: .mainImage8),
                title: "마녀 사냥",
                info: "신동엽의 19금 토크쇼 이제 시작."
            ),
            mainModel(
                image: UIImage(resource: .mainImage8),
                title: "마녀 사냥",
                info: "신동엽의 19금 토크쇼 이제 시작."
            ),
            mainModel(
                image: UIImage(resource: .mainImage8),
                title: "마녀 사냥",
                info: "신동엽의 19금 토크쇼 이제 시작."
            )
        ]
    }
    
    static func getImageDatas() -> [Int: [UIImage]] {
        return [
            1: [UIImage(resource: .mainImage9), UIImage(resource: .mainImage4), UIImage(resource: .thingjin), UIImage(resource: .mainImage5), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1), UIImage(resource: .mainImage1)],
            2: [UIImage(resource: .imgLive1), UIImage(resource: .imgLive2), UIImage(resource: .imgLive1), UIImage(resource: .imgLive2)],
            3: [UIImage(resource: .mainImage1), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage7)],
            4: [UIImage(resource: .imgAd1), UIImage(resource: .imgAd2), UIImage(resource: .mainImage2), UIImage(resource: .imgLive2)],
            5: [UIImage(resource: .mainImage8), UIImage(resource: .mainImage3), UIImage(resource: .mainImage2), UIImage(resource: .mainImage1)]
        ]
    }
    
    static func getTitleLists() -> [String] {
        return [
            "티빙에서 꼭 봐야하는 콘텐츠",
            "인기 LIVE 채널",
            "1화 무료! 파라마운트+ 인기 시리즈",
            "마술보다 더 신비로운 영화(신비로운 영화사전님)"
        ]
    }
}
