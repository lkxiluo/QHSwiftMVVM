//
//  Hummer.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/6.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

class HummerNetWorking: URLRequestConvertible, RequestConfigProtocol {
    var parameters: Dictionary<String, Any> = [:]
    
    static let `default` = HummerNetWorking()
    @discardableResult
    func request(params: Dictionary<String, Any>) -> HummerNetWorking {
        parameters = params
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(self)
        Alamofire.request(self)
        return self
    }
    
    func cancel() {
//        let cacheKey =
    }
    
    // MARK: -URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlRequest = requestURL()
        urlRequest.httpMethod = httpMethod().rawValue
        
        let params = mergeDictionary(to: parameters, from: commomParameters())
        let headers = SessionManager.defaultHTTPHeaders
        urlRequest.timeoutInterval = timeoutInterval()
        urlRequest.allHTTPHeaderFields = mergeDictionary(to: headers, from: httpHeaders()) as? [String : String]
        urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        
        return urlRequest
    }
    
    // MARK: -私有方法
    /// 合并两个数组
    private func mergeDictionary(to destinationDic: Dictionary<String, Any>, from sourceDic: Dictionary<String, Any>) -> Dictionary<String, Any> {
        var resultDic = destinationDic
        sourceDic.forEach { (key, value) in
            resultDic[key] = value
        }
        return resultDic
    }
    
    private func cacheKey() -> String {
        let urlString = requestURL().url?.absoluteString ?? ""
        let key = CacheKey.cacheKey(url: urlString, parameters: parameters, commomParameters: commomParameters())
        return key
    }
    
    private func requestURL() -> URLRequest {
        guard let url = try? baseURLString().asURL() else {
            return URLRequest(url: URL(string: "")!)
        }
        let urlRequest = URLRequest(url: url.appendingPathComponent(path()))
        return urlRequest;
    }
}


