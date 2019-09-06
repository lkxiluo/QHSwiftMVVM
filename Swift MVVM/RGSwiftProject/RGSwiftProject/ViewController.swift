//
//  ViewController.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/6/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DebugManager.log("我只是个测试")
        RosegalRouter().pathType(type: .default).requestParams(params: [:])
    }
}

