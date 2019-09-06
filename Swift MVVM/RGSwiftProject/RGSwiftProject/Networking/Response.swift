//
//  Response.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/30.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

/// 请求响应数据
public class Response {
    /// 数据所属请求
    let dataRequest: DataRequest
    /// 数据是否要缓存
    let isCache: Bool
    /// 数据要缓存的键
    let cacheKey: String
    /// 网络波动时，请求失败的请求是否要重新请求
    let isNeedReload: Bool
    /// 请求完成后移除请求的回调
    let completeHandle: (()->())?
    init(dataRequest: DataRequest, cache: Bool, cacheKey: String, needReload: Bool, completeHandle:(()->())?) {
        self.dataRequest = dataRequest
        self.isCache = cache
        self.cacheKey = cacheKey
        self.isNeedReload = needReload
        self.completeHandle = completeHandle
    }
    
    /// 缓存响应数据
    func response<T>(responseData: DataResponse<T>, completion:@escaping (ResponseModel<T>) -> Void) {
        responseCache(responseData: responseData) { (responseModel) in
            completion(responseModel)
        }
    }
    
    /// 缓存响应数据
    func responseCache<T>(responseData: DataResponse<T>, completion:@escaping (ResponseModel<T>) -> Void) {
        let result = ResponseModel(isCache: isCache, result: responseData.result, response: responseData.response)
        DebugManager.log("=========== 😆😆 这是请求的相关数据 ========")
        DebugManager.log("请求URL😆😆:" + (responseData.request?.url?.absoluteString ?? "这个链接是空的"))
        switch responseData.result {
        case .success(_):
            // 输出请求结果数据
            if let data = responseData.data, let resultString = String(bytes: data, encoding: .utf8) {
                DebugManager.log(resultString)
            }
            
            // 存储请求结果数据
            if isCache {
                var cacheModel = CacheModel()
                cacheModel.data = responseData.data
                CacheManager.default.setObject(object: cacheModel, for: cacheKey)
            }
            
            // 请求在结束后将其从请求数组中删除
            if let callBack = self.completeHandle {
                callBack()
            }
        case .failure(let error):
            // 如果不需要在断网到有网切换重新请求，请求在结束后将其从请求数组中删除
            if let callBack = self.completeHandle, isNeedReload {
                callBack()
            }
            DebugManager.log(error.localizedDescription)
        }
        completion(result)
    }
}

// MARK: 响应返回 Json 结构数据
public class JsonResponse: Response {
    /// 响应 Json 格式的数据
    func responseJson(completion: @escaping (ResponseModel<Any>) -> Void) {
        dataRequest.responseJSON { (response) in
            self.response(responseData: response, completion: completion)
        }
    }
    
    /// 从缓存中读取 Json 数据
    @discardableResult
    func responseJsonCache(completion: @escaping (Any) -> Void) -> JsonResponse {
        if let data = CacheManager.default.cacheObject(for: cacheKey)?.data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            DebugManager.log("================ 😆😆 这是缓存数据 =================")
            DebugManager.log("请求URL😆😆:" + (dataRequest.request?.url?.absoluteString ?? "这个链接是空"))
            if let jsonStr = String(bytes: data, encoding: .utf8) {
                DebugManager.log(jsonStr)
            }
            completion(json)
        } else {
            DebugManager.log(dataRequest.request?.url?.absoluteString ?? "这个链接是空" + "读取缓存失败")
        }
        return self
    }
    
    /// 如果支持缓存的话，先响应缓存数据，请求结束后再响应网络返回数据，相当于 XXX.responseJsonCache{}.responseJson{}
    func responseCacheThenJson(completion: @escaping (ResponseModel<Any>) -> Void) {
        if isCache {
            responseJsonCache { (json) in
                let model = ResponseModel(isCache: true, result: Alamofire.Result.success(json), response: nil)
                completion(model)
            }
        }
        dataRequest.responseJSON { (response) in
            self.responseCache(responseData: response, completion: completion)
        }
    }
}

// MARK: 响应返回 String 结构数据
public class StringResponse: Response {
    /// 响应 String 格式的数据
    func responseString(completion: @escaping (ResponseModel<String>) -> Void) {
        dataRequest.responseString { (string) in
            self.response(responseData: string, completion: completion)
        }
    }
    
    /// 从缓存中读取 String 数据
    @discardableResult
    func responseStringCache(completion: @escaping (String) -> Void) -> StringResponse {
        if let data = CacheManager.default.cacheObject(for: cacheKey)?.data,
            let string = String(bytes: data, encoding: .utf8) {
            DebugManager.log("================ 😆😆 这是缓存数据 =================")
            DebugManager.log("请求URL😆😆:" + (dataRequest.request?.url?.absoluteString ?? "这个链接是空"))
            DebugManager.log(string)
            completion(string)
        } else {
            DebugManager.log(dataRequest.request?.url?.absoluteString ?? "这个链接是空" + "读取缓存失败")
        }
        return self
    }
    
    /// 如果支持缓存的话，先响应缓存数据，请求结束后再响应网络返回数据，相当于 XXX.responseJsonCache{}.responseJson{}
    func responseCacheThenString(completion: @escaping (ResponseModel<String>) -> Void) {
        if isCache {
            responseStringCache { (string) in
                let model = ResponseModel(isCache: true, result: Alamofire.Result.success(string), response: nil)
                completion(model)
            }
        }
        dataRequest.responseString { (string) in
            self.responseCache(responseData: string, completion: completion)
        }
    }
}

// MARK: 响应返回 Data 结构数据
public class HDataResponse: Response {
    // 响应 Data 格式的数据
    func responseData(completion: @escaping (ResponseModel<Data>) -> Void) {
        dataRequest.responseData { (data) in
            self.response(responseData: data, completion: completion)
        }
    }
    
    // 从缓存中读取 Data 数据
    @discardableResult
    func responseDataCache(completion: @escaping (Data) -> Void) -> HDataResponse {
        if let data = CacheManager.default.cacheObject(for: cacheKey)?.data,
            let string = String(bytes: data, encoding: .utf8) {
            DebugManager.log("================ 😆😆 这是缓存数据 =================")
            DebugManager.log("请求URL😆😆:" + (dataRequest.request?.url?.absoluteString ?? "这个链接是空"))
            DebugManager.log(string)
            completion(data)
        } else {
            DebugManager.log(dataRequest.request?.url?.absoluteString ?? "这个链接是空" + "读取缓存失败")
        }
        return self
    }
    
    // 如果支持缓存的话，先响应缓存数据，请求结束后再响应网络返回数据，相当于 XXX.responseJsonCache{}.responseJson{}
    func responseCacheThenData(completion: @escaping (ResponseModel<Data>) -> Void) {
        if isCache {
            responseDataCache { (data) in
                let model = ResponseModel(isCache: true, result: Alamofire.Result.success(data), response: nil)
                completion(model)
            }
        }
        dataRequest.responseData { (data) in
            self.responseCache(responseData: data, completion: completion)
        }
    }
}
