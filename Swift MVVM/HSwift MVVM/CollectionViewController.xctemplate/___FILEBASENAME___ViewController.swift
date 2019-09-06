//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/// 实现XXXX功能，写功能注释
class ___VARIABLE_sceneName___ViewController: UIViewController {
    // MARK: 属性列表
    // MARK: --存储属性列表
    /// 属性注释
    private var someThing: String = ""
    
    // MARK: --计算/观察属性列表
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
    
    /// collectionView 列表
    lazy private var theCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12.0
        layout.minimumInteritemSpacing = 12.0
        layout.sectionInset = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = ColorStyle.backgroundF8F8F8()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        
        return collectionView
    }()
    
    // MARK: 方法重写
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: 添加视图和布局
    /// 添加视图
    private func setupView() {
        view.addSubview(theCollectionView)
    }
    
    /// 添加布局
    private func layout() {
        theCollectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
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
extension ___VARIABLE_sceneName___ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ccell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        return ccell
    }
    
}
