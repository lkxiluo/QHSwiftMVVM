//
//  Hummer.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/6.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

struct NetWorking {
    
    /// 配置缓存的过期时间
    public static func cacheExpiryConfig(expiry: CacheExpiry) {
        CacheManager.default.config(expired: expiry)
    }
    
    // MARK: https 网络请求
    /// 发起网络请求
    ///
    /// - Parameter urlRequest: 请求的路由相关数据
    /// - Returns: 
    @discardableResult
    static func request(urlRequest: RequestRouter) -> RequestTaskManager? {
        return RequestManager.default.request(urlRequest: urlRequest)
    }
    
    /// 取消发起的请求
    static func cancelRequest(urlRequest: RequestRouter) {
        RequestManager.default.cancelTask(urlRequest: urlRequest)
    }
    
    /// 取消发起的所有请求
    static func cancelAllRequest(urlRequest: RequestRouter) {
        RequestManager.default.cancelAllTask()
    }
    
    /// 移除某个请求的缓存
    static func removeCache(urlRequest: RequestRouter, completion: @escaping (Bool)->()) {
        RequestManager.default.removeObjectCache(urlRequest: urlRequest, completion: completion)
    }
    
    static func removeAllCache(completion: @escaping (Bool)->()) {
        RequestManager.default.removeAllCache(completion: completion)
    }
    
    // TODO: 待扩展，上传下载
    // MARK: 上传下载
}
