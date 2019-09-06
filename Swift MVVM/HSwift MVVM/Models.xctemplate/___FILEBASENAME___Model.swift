//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftyJSON

/// XXX 数据模型
struct ___VARIABLE_modelName___Model {
    /// 某些属性，一般定义为不可变属性
    let someThing: String?
    let bornIn: String?
    /// 键值映射，当数据模型中有类似于 bornIn 与字段 ”born_in“ 不一致时使用，具体看 CodingKey 的使用
    enum CodingKeys: String, CodingKey {
        case someThing
        case bornIn = "born_in"
    }
}

