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
    
    /// 初始化，手动解析
    init(json: JSON) {
        someThing = json["some_thing"].stringValue
    }
}

