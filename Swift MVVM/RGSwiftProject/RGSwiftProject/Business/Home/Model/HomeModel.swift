//
//  HomeModel.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/2.
//  Copyright (c) 2019 karl.luo. All rights reserved.
//

import UIKit

/// XXX 数据模型
struct HomeModel: Codable {
    /// 某些属性，一般定义为不可变属性
    let name: String
    let age: Int
    let bornIn: String
    let timeInv: String
    let blogUrl: String
    
    /// 键值映射
//    enum CodingKeys: String, CodingKey {
//        case name
//        case age
//        case bornIn = "born_in"
//        case timeInv
//        case blogUrl
//    }
//    
}

