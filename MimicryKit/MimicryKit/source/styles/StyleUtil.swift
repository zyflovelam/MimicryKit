//
//  StyleUtil.swift
//  MimicryKit
//
//  Created by zyf on 2021/1/16.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
