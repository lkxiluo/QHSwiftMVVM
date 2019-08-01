//
//  ViewController.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/6/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
//        btn.isAccessibilityElement = true
//        btn.accessibilityLabel = "Slide"
        btn.setTitle("Slide", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: 20.0, y: 100.0, width: 88.0, height: 36.0)
        btn.backgroundColor = .orange
        btn.addTarget(self, action: #selector(slideAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = true
        label.accessibilityLabel = "nickNameLabel"
        label.frame = CGRect(x: 20.0, y: 150.0, width: 200.0, height: 20.0)
        label.textColor = UIColor.purple
        label.text = "Get as close as you can to: "
        return label
    }()
    
    lazy var nickDescriptionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20.0, y: 150.0, width: 200.0, height: 20.0)
        label.textColor = UIColor.purple
        label.text = "Get as close as you can to: "
        return label
    }()
    
    @objc func slideAction() {
        print("############ slideAction")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.addSubview(nickNameLabel)
        view.addSubview(nickDescriptionLabel)
    }

    func isUnlockSuccess(number1: Int, number2: Int) -> Bool {
        if number1 == 3 && number2 == 7 {
            return true
        } else {
            return false
        }
    }
}

