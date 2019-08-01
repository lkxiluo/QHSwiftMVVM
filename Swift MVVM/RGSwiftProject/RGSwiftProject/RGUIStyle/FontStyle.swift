//
//  FontStyle.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/7/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation

import UIKit

fileprivate let boldFontName = "Rubik-Medium"
fileprivate let fontName = "Rubik-Regular"
/// UI 设计样式字体规范
struct FontStyle {
    
    static func bold20() -> UIFont {
        return FontStyle.boldFont(size: 20.0)
    }
    
    static func bold16() -> UIFont {
        return FontStyle.boldFont(size: 16.0)
    }
    
    static func main14() -> UIFont {
        return FontStyle.font(size: 14.0)
    }
    
    static func font12() -> UIFont {
        return FontStyle.font(size: 12.0)
    }
    
    static func font10() -> UIFont {
        return FontStyle.font(size: 10.0)
    }
    
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: boldFontName, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func font(size: CGFloat) -> UIFont {
        return UIFont.init(name: fontName, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
