//
//  UIColor+Covert.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/7/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import UIKit

// 颜色置换
extension UIColor {
    /// 将十六进制的颜色值转换为UIColor
    ///
    /// - Parameters:
    ///   - hexColor: 要转化的十六进制颜色值，格式为0xFF0000
    ///   - alpha: 颜色的透明度
    /// - Returns: 转换后的颜色值
    class func color(hexColor: NSInteger, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: ((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hexColor & 0xFF)) / 255.0, alpha: alpha)
    }
    
    class func color(hexColor:NSInteger) -> UIColor {
        return UIColor.color(hexColor: hexColor, alpha: 1.0)
    }
}
