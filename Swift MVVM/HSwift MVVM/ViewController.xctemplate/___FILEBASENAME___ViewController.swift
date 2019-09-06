//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
// 每个 MARK 没有内容时，删除掉样例，保留 MARK 注解

import Foundation
import UIKit
import SnapKit

/// 实现XXXX功能，写功能注释
class ___VARIABLE_sceneName___ViewController: UIViewController {
    // MARK: 属性列表
    // MARK: --存储属性列表
    /// 属性注释
    private var someThing: String = ""
    
    // MARK: --计算属性列表
    var _name: String = ""
    /// 名字
    var name: String {
        get {
            return _name
        }
        
        set {
            _name = newValue
        }
    }
    
    //MARK: --观察属性列表
    /// 昵称
    var nickName: String? {
        willSet {
            
        }
        
        didSet {
            
        }
    }
    
    // MARK: --控件属性列表
    /// 按钮注释
    lazy private var button: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        return button
    }()
    
    // MARK: 方法重写
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: 添加视图和布局
    /// 添加视图
    private func setupView() {
    }
    
    /// 添加布局
    private func layout() {
    }
    
    // MARK: 事件响应
    /// XXX 点击事件
    @objc private func click(sender: UIButton) {
        
    }
    
    // MARK: 私有方法
    /// 给方法添加注释
    private func methodA() {
        
    }
    
    // MARK: 公有方法
    /// 给方法添加注释
    func methodB() {
        
    }
}

// MARK: 协议扩展
extension ___VARIABLE_sceneName___ViewController: UINavigationControllerDelegate {
    
}

