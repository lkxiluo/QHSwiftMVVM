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
        let parameters: Parameters = ["foo": "bar"]
        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
    }
}

