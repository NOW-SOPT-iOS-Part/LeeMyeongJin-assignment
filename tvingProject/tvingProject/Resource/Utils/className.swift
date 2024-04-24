//
//  className.swift
//  tvingProject
//
//  Created by 이명진 on 4/23/24.
//

import UIKit

extension NSObject {
    public static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    public var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
