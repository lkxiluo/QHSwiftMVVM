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
    //
    func request(urlRequest: RequestRouter) -> RequestTaskManager? {
        if let _ = urlRequest.urlRequest?.url?.absoluteString {
            let key = urlRequest.cacheKey()
            var taskManager : RequestTaskManager?
            if requestTasks[key] == nil {
                taskManager = RequestTaskManager()
                requestTasks[key] = taskManager
            } else {
                taskManager = requestTasks[key]
            }
            
            taskManager?.completionHandle = {
                self.requestTasks.removeValue(forKey: key)
            }
            
            taskManager?.request(urlRequest: urlRequest)
            return taskManager!
        }
        return nil
    }
    
    /// 取消请求任务
    func cancelTask(urlRequest: RequestRouter) {
        if let _ = urlRequest.urlRequest?.url?.absoluteString {
            let key = urlRequest.cacheKey()
            let taskManager = requestTasks[key]
            taskManager?.dataRequest?.cancel()
        }
    }
    
    /// 取消所有请求任务
    func cancelAllTask() {
        requestTasks.forEach { (key, task) in
            task.dataRequest?.cancel()
        }
    }
    
    /// 清除所有缓存
    func removeAllCache(completion: @escaping (Bool)->()) {
        CacheManager.default.removeAllObject(completeHandle: completion)
    }
    
    /// 根据 key 值清除缓存
    func removeObjectCache(urlRequest: RequestRouter, completion: @escaping (Bool)->()) {
        if let _ = urlRequest.urlRequest?.url?.absoluteString {
            let key = urlRequest.cacheKey()
            CacheManager.default.removeObject(for: key, completeHandle: completion)
        }
    }
}
