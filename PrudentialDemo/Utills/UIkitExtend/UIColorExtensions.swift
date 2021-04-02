//
//  UIColorExtensions.swift
//  EddidOne
//
//  Created by IMac  on 2020/4/14.
//  Copyright © 2020 Ad. All rights reserved.
//

import UIKit

extension UIColor {
    /// 获取颜色
    /// - Parameters:
    ///   - red: 红 0-255
    ///   - green: 绿 0-255
    ///   - blue: 蓝 0-255
    ///   - alpha: 透明度 0-1   1代表不透明  0代表透明
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        var red = red
        var green = green
        var blue = blue
        if red < 0 {
            red = 0
        } else if red > 255 {
            red = 255
        }
        if green < 0 {
            green = 0
        } else if green > 255 {
            green = 255
        }
        if blue < 0 {
            blue = 0
        } else if blue > 255 {
            blue = 255
        }
        var alpha = alpha
        if alpha < 0 {
            alpha = 0
        } else if alpha > 1 {
            alpha = 1
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    /// 创建颜色
    /// - Parameters:
    ///   - hexString: 16进制颜色【不包含透明度】
    ///   - alpha: 透明度    1代表不透明  0代表透明
    convenience init(hexString: String, alpha: CGFloat) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        var alpha: CGFloat = alpha
        if alpha < 0 { alpha = 0 }
        if alpha > 1 { alpha = 1 }
        let hexValue = Int(string, radix: 16)
        if let hexValue = hexValue {
            let red = (hexValue >> 16) & 0xff
            let green = (hexValue >> 8) & 0xff
            let blue = hexValue & 0xff
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            print("16进制颜色字符串出错，默认返回透明色")
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    /// 创建颜色
    /// - Parameter hexString: 16进制颜色【可包含透明度】
    convenience init(hexString: String) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        if string.count == 8 {
            let hexValue = Int(string, radix: 16)
            if let hexValue = hexValue {
                let alpha = (hexValue >> 24) & 0xff
                self.init(hexString: string, alpha: CGFloat(alpha) / 255.0)
            } else {
                print("16进制颜色字符串出错，默认返回透明色")
                self.init(red: 0, green: 0, blue: 0, alpha: 0)
            }
        } else {
            self.init(hexString: string, alpha: 1)
        }
    }
}
