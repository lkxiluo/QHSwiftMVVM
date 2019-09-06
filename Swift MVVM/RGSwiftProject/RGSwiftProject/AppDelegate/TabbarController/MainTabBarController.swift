//
//  MainTabBarViewController.swift
//  Zaful
//
//  Created by QianHan on 2017/11/20.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class MainTabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabarController()
    }

    private func setupTabarController() -> Void {
        let homeMainViewController = HomeViewController()
        childViewController(homeMainViewController, LocalizedString("tabbar_title_home"), UIImage(named: "tabbar_home_normal")!, UIImage(named: "tabbar_home_selected")!)
        
        let categorysViewController = CategoryViewController()
        childViewController(categorysViewController, LocalizedString("tabbar_title_category"), UIImage(named: "tabbar_category_normal")!, UIImage(named: "tabbar_category_selected")!)
        
        let communityViewController = CommunityViewController()
        childViewController(communityViewController, LocalizedString("tabbar_title_z-me"), UIImage(named: "tabbar_z-me_normal")!, UIImage(named: "tabbar_z-me_selected")!)
        
        let showViewController = BagViewController()
        childViewController(showViewController, LocalizedString("tabbar_title_favorite"), UIImage(named: "tabbar_favorite_normal")!, UIImage(named: "tabbar_favorite_normal")!)
        
        let accountViewController = AccountViewController()
        childViewController(accountViewController, LocalizedString("tabbar_title_mine"), UIImage(named: "tabbar_mine_normal")!, UIImage(named: "tabbar_mine_selected")!)
    }
    
    private func childViewController(_ viewController: UIViewController, _ title: String, _ normalImage: UIImage,  _ selectedImage: UIImage) -> Void {
        let navigationBar = UINavigationController(rootViewController: viewController)
        navigationBar.tabBarItem = ESTabBarItem.init(TabbarBouncesContentView(), title: title, image: normalImage, selectedImage: selectedImage)
        viewController.navigationItem.title = title
        addChild(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
