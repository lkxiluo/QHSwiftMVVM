//
//  RequestTaskManager.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/9/3.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - 请求任务
public class RequestTaskManager {
    // 当前的任务请求
    var dataRequest: DataRequest?
    // 当前请求是否需要缓存
    var isCache: Bool = false
    // 当前缓存的键
    var cacheKey: String!
    // 当网络变更后，当前请求是否需要重新加载
    var isNeedReload: Bool = false
    // 请求结束后回调
    var completionHandle: (()->())?
    
    @discardableResult
    func request(urlRequest: RequestRouter) -> RequestTaskManager {
        self.cacheKey = urlRequest.cacheKey()
        dataRequest = Alamofire.request(urlRequest)
        return self
    }
    
    /// 是否缓存数据
    public func cache(_ cache: Bool) -> RequestTaskManager {
        self.isCache = cache
        return self
    }
    
    /// 是否缓存数据
    public func needReload(_ needReload: Bool) -> RequestTaskManager {
        self.isNeedReload = needReload
        return self
    }
    
    // MARK: 请求响应 Data 数据
    /// 获取缓存 Data
    @discardableResult
    public func cacheData(completion: @escaping (Data) -> ()) -> HDataResponse {
        let dataResponse = HDataResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        return dataResponse.responseDataCache(completion: completion)
     }
    
    /// 响应 Data
    public func responseData(completion: @escaping (ResponseModel<Data>) -> ()) {
        let dataResponse = HDataResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        dataResponse.responseData(completion: completion)
    }
    
    /// 先获取 Data 缓存，再响应 Data
    public func responseCacheThenData(completion: @escaping (ResponseModel<Data>) -> ()) {
        let dataResponse = HDataResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        dataResponse.responseCacheThenData(completion: completion)
    }
    
    // MARK: 请求响应 String 数据
    /// 获取缓存 String
    @discardableResult
    public func cacheString(completion: @escaping (String)->()) -> StringResponse {
        let stringResponse = StringResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        return stringResponse.responseStringCache(completion: completion)
    }
    
    /// 响应 String
    public func responseString(completion: @escaping (ResponseModel<String>) -> ()) {
        let stringResponse = StringResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        stringResponse.responseString(completion: completion)
    }
    
    /// 先获取缓存 String, 再响应String
    public func responseCacheThenString(completion: @escaping (ResponseModel<String>)->()) {
        let stringResponse = StringResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        stringResponse.responseCacheThenString(completion: completion)
    }
    
    // MARK: 请求响应 JSON 数据
    /// 获取缓存 JSON
    @discardableResult
    public func cacheJson(completion: @escaping (Any)->()) -> JsonResponse {
        let jsonResponse = JsonResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        return jsonResponse.responseJsonCache(completion: completion)
    }
    
    /// 响应 JSON
    public func responseJson(completion: @escaping (ResponseModel<Any>)->()) {
        let jsonResponse = JsonResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        jsonResponse.responseJson(completion: completion)
    }
    
    /// 先获取缓存JSON，再响应JSON
    public func responseCacheThenJson(completion: @escaping (ResponseModel<Any>)->()) {
        let jsonResponse = JsonResponse(dataRequest: dataRequest!, cache: isCache, cacheKey: cacheKey, needReload: isNeedReload, completeHandle: completionHandle)
        jsonResponse.responseCacheThenJson(completion: completion)
    }
}
