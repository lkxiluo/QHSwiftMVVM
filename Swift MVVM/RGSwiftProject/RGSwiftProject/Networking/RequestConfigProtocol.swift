//
//  RequestConfigProtocol.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/16.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

/// 网络请求的配置协议，比如公共参数，请求头，基本 URL 等等
protocol RequestConfigProtocol {
    /// 请求基础 URL
    func baseURLString() -> String
    /// http 请求头
    func httpHeaders() -> HTTPHeaders
    /// http 请求方法, get/post/delete...
    func httpMethod() -> HTTPMethod
    /// 请求路由路径
    func path() -> String
    /// 请求参数
    func parameters() -> [String: Any]
    /// 公共参数
    func commomParameters() -> [String: Any]
    /// 是否加密
    func isEncryption() -> Bool
    /// 是否需要先读取缓存，请求回来后再刷新最新数据
    func isCacheResponse() -> Bool
    /// 请求超时时间
    func timeoutInterval() -> TimeInterval
}

extension RequestConfigProtocol {
    func baseURLString() -> String {
        return ""
    }
    
    func httpHeaders() -> HTTPHeaders {
        return ["Accept": "application/json",
                "content-type": "application/json"
        ]
    }
    
    func httpMethod() -> HTTPMethod {
        return .post
    }
    
    func path() -> String {
        return ""
    }
    
    func parameters() -> [String : Any] {
        return [:]
    }
    
    func commomParameters() -> [String: Any] {
        return [:]
    }
    
    func isEncryption() -> Bool {
        return true
    }
    
    func isCacheResponse() -> Bool {
        return false
    }
    
    func timeoutInterval() -> TimeInterval {
        return 15.0
    }
}
