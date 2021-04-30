//
//  UIColorExtensions.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/27.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static let primary_default = UIColor(r: 70, g: 48, b: 255)
    static let primary_fade = UIColor(r: 99, g: 81, b: 255)
    static let primary_dark = UIColor(r: 55, g: 37, b: 208)
    static let secondary_red_default = UIColor(r: 254, g: 84, b: 54)
    static let secondary_red_dark = UIColor(r: 183, g: 59, b: 37)
    static let secondary_blue_default = UIColor(r: 83, g: 138, b: 255)
    static let secondary_blue_dark = UIColor(r: 47, g: 81, b: 153)
    static let sub_black_b1 = UIColor(r: 25, g: 24, b: 32)
    static let sub_black_b2 = UIColor(r: 28, g: 26, b: 56)
    static let sub_black_b3 = UIColor(r: 37, g: 32, b: 68)
    static let sub_black_b4 = UIColor(r: 41, g: 37, b: 88)
    static let sub_black_b5 = UIColor(r: 104, g: 102, b: 140)
    static let sub_white_w1 = UIColor(r: 244, g: 244, b: 244)
    static let sub_white_w2 = UIColor(r: 255, g: 255, b: 255)
    static let sub_white_w3 = UIColor(r: 218, g: 214, b: 255)
    static let sub_white_w4 = UIColor(r: 177, g: 167, b: 255)
    static let sub_gray_100 = UIColor(r: 24, g: 24, b: 30)
    static let sub_gray_80 = UIColor(r: 50, g: 50, b: 56)
    static let sub_gray_60 = UIColor(r: 90, g: 90, b: 98)
    static let sub_gray_40 = UIColor(r: 160, g: 160, b: 168)
    static let sub_gray_20 = UIColor(r: 200, g: 200, b: 204)
}
