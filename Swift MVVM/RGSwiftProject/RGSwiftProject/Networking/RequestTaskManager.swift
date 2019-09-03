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
    var dataRequest: DataRequest?
    var cache: Bool = false
    var cacheKey: String!
    var sessionManager: SessionManager?
    var completionClosure: (()->())?
    
    @discardableResult
    func timeoutIntervalForRequest(_ timeInterval :TimeInterval) -> RequestTaskManager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeInterval
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        self.sessionManager = sessionManager
        return self
    }
    
    @discardableResult
    func request(_ url: String, method: HTTPMethod = .get, params: Parameters? = nil, cacheKey: String, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> RequestTaskManager {
        self.cacheKey = cacheKey
        if sessionManager != nil {
            dataRequest = sessionManager?.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        } else {
            dataRequest = Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        }
        return self
    }
    
    @discardableResult
    func request(urlRequest: URLRequestConvertible, cacheKey: String) -> RequestTaskManager {
        self.cacheKey = cacheKey
        if sessionManager != nil {
            dataRequest = sessionManager?.request(urlRequest)
        } else {
            dataRequest = Alamofire.request(urlRequest)
        }
        return self
    }
    
    /// 是否缓存数据
    public func cache(_ cache: Bool) -> RequestTaskManager {
        self.cache = cache
        return self
    }
    
    /*
     /// 获取缓存Data
     @discardableResult
     public func cacheData(completion: @escaping (Data)->()) -> HDataResponse {
     let dataResponse = HDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     return dataResponse.cacheData(completion: completion)
     }
     /// 响应Data
     public func responseData(completion: @escaping (DaisyValue<Data>)->()) {
     let dataResponse = DaisyDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     dataResponse.responseData(completion: completion)
     }
     /// 先获取Data缓存，再响应Data
     public func responseCacheAndData(completion: @escaping (DaisyValue<Data>)->()) {
     let dataResponse = DaisyDataResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     dataResponse.responseCacheAndData(completion: completion)
     }
     /// 获取缓存String
     @discardableResult
     public func cacheString(completion: @escaping (String)->()) -> DaisyStringResponse {
     let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     return stringResponse.cacheString(completion:completion)
     }
     /// 响应String
     public func responseString(completion: @escaping (DaisyValue<String>)->()) {
     let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     stringResponse.responseString(completion: completion)
     }
     /// 先获取缓存String,再响应String
     public func responseCacheAndString(completion: @escaping (DaisyValue<String>)->()) {
     let stringResponse = DaisyStringResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     stringResponse.responseCacheAndString(completion: completion)
     }
     /// 获取缓存JSON
     @discardableResult
     public func cacheJson(completion: @escaping (Any)->()) -> DaisyJsonResponse {
     let jsonResponse = DaisyJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     return jsonResponse.cacheJson(completion:completion)
     }
     /// 响应JSON
     public func responseJson(completion: @escaping (DaisyValue<Any>)->()) {
     let jsonResponse = DaisyJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     jsonResponse.responseJson(completion: completion)
     }
     /// 先获取缓存JSON，再响应JSON
     public func responseCacheAndJson(completion: @escaping (DaisyValue<Any>)->()) {
     let jsonResponse = DaisyJsonResponse(dataRequest: dataRequest!, cache: cache, cacheKey: cacheKey, completionClosure: completionClosure)
     jsonResponse.responseCacheAndJson(completion: completion)
     }*/
}
