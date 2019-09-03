//
//  RequestManager.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/9/3.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    static let `default` = RequestManager()
    private var requestTasks = [String: RequestTaskManager]()
    private var timeoutIntervalForRequest: TimeInterval? /// 超时时间
    
    func timeoutIntervalForRequest(_ timeInterval :TimeInterval) {
        self.timeoutIntervalForRequest = timeInterval
        RequestManager.default.timeoutIntervalForRequest = timeoutIntervalForRequest
    }
    
    func request(_ url: String, method: HTTPMethod = .get, params: Parameters? = nil, dynamicParams: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> RequestTaskManager {
        let key = CacheKey.cacheKey(url: url, parameters: params, commomParameters: dynamicParams)
        var taskManager : RequestTaskManager?
        if requestTasks[key] == nil {
            if timeoutIntervalForRequest != nil {
                taskManager = RequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
            } else {
                taskManager = RequestTaskManager()
            }
            requestTasks[key] = taskManager
        } else {
            taskManager = requestTasks[key]
        }
        
        taskManager?.completionClosure = {
            self.requestTasks.removeValue(forKey: key)
        }
        var tempParam = params==nil ? [:] : params!
        let dynamicTempParam = dynamicParams==nil ? [:] : dynamicParams!
        dynamicTempParam.forEach { (arg) in
            tempParam[arg.key] = arg.value
        }
        taskManager?.request(url, method: method, params: tempParam, cacheKey: key, encoding: encoding, headers: headers)
        return taskManager!
    }
    
    func request(urlRequest: URLRequestConvertible, params: Parameters, dynamicParams: Parameters? = nil) -> RequestTaskManager? {
        if let urlStr = urlRequest.urlRequest?.url?.absoluteString {
            let components = urlStr.components(separatedBy: "?")
            if components.count > 0 {
                let key = CacheKey.cacheKey(url: components.first!, parameters: params, commomParameters: dynamicParams)
                var taskManager : RequestTaskManager?
                if requestTasks[key] == nil {
                    if timeoutIntervalForRequest != nil {
                        taskManager = RequestTaskManager().timeoutIntervalForRequest(timeoutIntervalForRequest!)
                    } else {
                        taskManager = RequestTaskManager()
                    }
                    requestTasks[key] = taskManager
                } else {
                    taskManager = requestTasks[key]
                }
                
                taskManager?.completionClosure = {
                    self.requestTasks.removeValue(forKey: key)
                }
                var tempParam = params
                let dynamicTempParam = dynamicParams == nil ? [:] : dynamicParams!
                dynamicTempParam.forEach { (arg) in
                    tempParam[arg.key] = arg.value
                }
                taskManager?.request(urlRequest: urlRequest, cacheKey: key)
                return taskManager!
            }
            return nil
        }
        return nil
    }
    
    
    /// 取消请求
    func cancel(_ url: String, params: Parameters? = nil, dynamicParams: Parameters? = nil) {
        let key = CacheKey.cacheKey(url: url, parameters: params, commomParameters: dynamicParams)
        let taskManager = requestTasks[key]
        taskManager?.dataRequest?.cancel()
    }
    
    /// 清除所有缓存
    func removeAllCache(completion: @escaping (Bool)->()) {
        CacheManager.default.removeAllObject(completeHandle: completion)
    }
    
    /// 根据key值清除缓存
    func removeObjectCache(_ url: String, params: [String: Any]? = nil, dynamicParams: Parameters? = nil,  completion: @escaping (Bool)->()) {
        let key = CacheKey.cacheKey(url: url, parameters: params, commomParameters: dynamicParams)
        CacheManager.default.removeObject(for: key, completeHandle: completion)
    }
}
