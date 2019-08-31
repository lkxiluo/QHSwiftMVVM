//
//  Hummer.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/6.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

protocol NetWorkingResponseDelegate {
    func requestSuccess(result: ResponseModel<Any>) -> Void
    func requestFailed(result: ResponseModel<Any>) -> Void
}

class HummerNet: URLRequestConvertible, RequestConfigProtocol {
    var parameters: Dictionary<String, Any> = [:]
    
    static let `default` = HummerNet()
    @discardableResult
    func request(params: Dictionary<String, Any>) -> HummerNet {
        parameters = params
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(self)
        Alamofire.request(self)
        return self
    }
    
    // MARK: -URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString().asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path()))
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
    func mergeDictionary(to destinationDic: Dictionary<String, Any>, from sourceDic: Dictionary<String, Any>) -> Dictionary<String, Any> {
        var resultDic = destinationDic
        sourceDic.forEach { (key, value) in
            resultDic[key] = value
        }
        return resultDic
    }
}
