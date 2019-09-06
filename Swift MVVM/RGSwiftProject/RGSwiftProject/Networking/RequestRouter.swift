//
//  HummerURLRequest.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/9/3.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

class RequestRouter: URLRequestConvertible, RequestConfigProtocol {
    var parameters: Dictionary<String, Any> = [:]
    
    // MARK: -RequestConfigProtocol
    func baseURLString() -> String {
        return ""
    }
    
    func httpHeaders() -> HTTPHeaders {
        return [:]
    }
    
    func httpMethod() -> HTTPMethod {
        return .post
    }
    
    func path() -> String {
        return ""
    }
    
    func commomParameters() -> Dictionary<String, Any> {
        return [:]
    }
    
    func isEncryption() -> Bool {
        return false
    }
    
    func timeoutInterval() -> TimeInterval {
        return 15.0
    }
    
    func encoding() -> ParameterEncoding {
        return URLEncoding.default
    }
    
    // MARK: -URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlRequest = requestURL()
        urlRequest.httpMethod = httpMethod().rawValue
        
        let params = mergeDictionary(to: parameters, from: commomParameters())
        let headers = SessionManager.defaultHTTPHeaders
        urlRequest.timeoutInterval = timeoutInterval()
        urlRequest.allHTTPHeaderFields = mergeDictionary(to: headers, from: httpHeaders()) as? [String : String]
        urlRequest = try encoding().encode(urlRequest, with: params)
        
        return urlRequest
    }
    
    /// 请求参数
    @discardableResult
    final func requestParams(params: Dictionary<String, Any>) -> RequestRouter {
        parameters = params
        return self
    }
    
    // MARK: -公有方法
    /// 获取缓存键
    final func cacheKey() -> String {
        let urlString = requestURL().url?.absoluteString ?? ""
        let key = CacheKey.cacheKey(url: urlString, parameters: parameters, commomParameters: commomParameters())
        return key
    }
    
    /// 合并两个数组
    func mergeDictionary(to destinationDic: Dictionary<String, Any>, from sourceDic: Dictionary<String, Any>) -> Dictionary<String, Any> {
        var resultDic = destinationDic
        sourceDic.forEach { (key, value) in
            resultDic[key] = value
        }
        return resultDic
    }
    
    /// 请求链接
    func requestURL() -> URLRequest {
        guard let url = try? baseURLString().asURL() else {
            return URLRequest(url: URL(string: "")!)
        }
        
        if path().count > 0 {
            let urlRequest = URLRequest(url: url.appendingPathComponent(path()))
            return urlRequest;
        }
        return URLRequest(url: url)
    }
}

