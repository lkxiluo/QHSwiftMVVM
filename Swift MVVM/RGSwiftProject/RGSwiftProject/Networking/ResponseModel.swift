//
//  ResponseModel.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/29.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

/// 请求结构相关数据
public struct ResponseModel<Value> {
    // 是否是缓存数据
    public let isCacheResponse: Bool
    // 请求响应的结果
    public let result: Alamofire.Result<Value>
    // 响应结果
    public let response: HTTPURLResponse?
    init(isCache: Bool, result: Alamofire.Result<Value>, response: HTTPURLResponse?) {
        self.isCacheResponse = isCache
        self.result = result
        self.response = response
    }
}
