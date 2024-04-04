//
//  FontLiterals.swift
//  34th sopt 1th Seminar
//
//  Created by 이명진 on 4/5/24.
//
import UIKit

extension UIFont {
    @nonobjc class var head01: UIFont {
        return UIFont.font(.pretendardExtraBold, ofSize: 25)
    }
    
    @nonobjc class var subhead01: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    @nonobjc class var subhead02: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 16)
    }

    @nonobjc class var subhead03: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 15)
    }
    
    @nonobjc class var subhead04: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 14)
    }

    @nonobjc class var subhead05: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 14)
    }

    @nonobjc class var info: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 14)
    }
}

enum FontName: String {
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardBold = "Pretendard-Bold"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardSemiBold = "Pretendard-SemiBold"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            print("Failed to load the \(style.rawValue) font. Return system font instead.")
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
