//
//  Formatter.swift
//  tvingProject
//
//  Created by 이명진 on 5/8/24.
//

import UIKit

struct Formatter {
    static func formatNumberKoreanStyle(_ numberString: String) -> String? {
        guard let number = Int(numberString) else { return "오류" }
        
        if number >= 10000 {
            let manNumber = number / 10000
            return "\(manNumber)만 명"
        } else {
            // 만 단위 미만일 경우 콤마를 사용한 형식에 "명" 추가
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let formattedNumber = formatter.string(from: NSNumber(value: number)) {
                return "\(formattedNumber)명"
            }
        }
        return nil
    }
}
