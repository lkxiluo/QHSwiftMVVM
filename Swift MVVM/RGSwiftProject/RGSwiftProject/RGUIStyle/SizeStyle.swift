//
//  SizeStyle.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/7/11.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import UIKit

/// UI 设计样式尺寸规范
struct SizeStyle {
    /// 屏幕分辨倍数
    static let scale = UIScreen.main.scale
    /// 状态栏高度
    static let statusHeight = UIApplication.shared.statusBarFrame.height
    /// 屏幕宽度
    static let screenWidth = UIScreen.main.bounds.size.width
    /// 屏幕高度
    static let screenHeight = UIScreen.main.bounds.size.height
    /// 工具栏或 tab 栏高度
    static let toolHeight: CGFloat = 44.0
    /// 可点击提示视图高度
    static let tapTipHeight: CGFloat = 36.0
    /// 底部工具栏高度
    static let bottomToolHeight: CGFloat = 56.0
    /// 常规列表单元高度
    static let tableCellHeight: CGFloat = 48.0
    /// 列表单元间隔
    static let cellSpace: CGFloat = 8.0
    /// 控件边距
    static let margin: CGFloat = 16.0
    /// 内间距
    static let innerSpace: CGFloat = 12.0
    /// 分割线高度
    static let seperatorHeight: CGFloat = 1.0 / SizeStyle.scale * 2
}
