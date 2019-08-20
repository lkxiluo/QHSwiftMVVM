//
//  Hummer.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/6.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

class HummerNet: URLRequestConvertible, RequestConfigProtocol {
    static let `default` = HummerNet()
    private var requestTasks = [String: HummerNet]()
    var requestArray: [DataRequest] = [DataRequest]()
    func request() -> Void {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(self)
        Alamofire.request(self)
    }
    
    // MARK: -URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString().asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path()))
        urlRequest.httpMethod = httpMethod().rawValue
        
        let headers = SessionManager.defaultHTTPHeaders
        urlRequest.timeoutInterval = timeoutInterval()
        urlRequest.allHTTPHeaderFields = mergeDictionary(to: headers, from: httpHeaders())
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters())
        
        return urlRequest
    }
    
    /// 合并两个数组
    func mergeDictionary(to: [String: String], from: [String: String]) -> [String: String] {
        var resultDic = to
        for dic in from {
            resultDic[dic.key] = from[dic.key]
        }
        return resultDic
    }
}
