//
//  MainTabBarViewController.swift
//  Zaful
//
//  Created by QianHan on 2017/11/20.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabbarBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = ColorStyle.text222222()
        iconColor = ColorStyle.text222222()
        
        highlightTextColor = .black
        highlightIconColor = .black
        badgeColor         = ColorStyle.mainFA386A()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
