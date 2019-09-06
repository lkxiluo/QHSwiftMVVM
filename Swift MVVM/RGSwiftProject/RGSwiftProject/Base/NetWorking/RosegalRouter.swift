//
//  BaseNetWorking.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

/// 请求路径类型
enum RouterPathType: String {
    case `default` = ""
    case command = "common.php"
    case user = "user.php"
    case cart = "cart.php"
    case tetVersion = "get_version_path.php"
}

class RosegalRouter: RequestRouter {
    private var pathRouter: RequestRouterPath = .default
    private var pathType: RouterPathType = .default
    
    // MARK: -RequestConfigProtocol，根据实际情况配置
    override func baseURLString() -> String {
        let baseURL = "https://app.rosegal.com"
        if (pathType == .default || pathType == .tetVersion) {
            return baseURL;
        }
        return baseURL.appending("/api_iphone_2.0")
    }
    
    override func httpMethod() -> HTTPMethod {
        switch pathRouter {
        default:
            return .post
        }
    }
    
    override func path() -> String {
        return pathRouter.rawValue
    }
    
    override func commomParameters() -> [String: Any] {
        // TODO: 暂时写死
        var commParams = [String: Any]()
        commParams["app"] = 1
        commParams["version"] = "3.6.2"
        commParams["lang"] = "en"
        commParams["country_code"] = "US"
        commParams["device_id"] = "F4F2C0D6-4DBF-4002-B56F-3A9421DA7221"
        commParams["m_action"] = path()
        if (pathType == .default || pathType == .tetVersion) {
            commParams["appId"] = "1159274056"
            commParams["version"] = "3.6.2"
            commParams["deviceId"] = "F4F2C0D6-4DBF-4002-B56F-3A9421DA7221"
        }
        return commParams
    }
    
    override func isEncryption() -> Bool {
        return false
    }
    
    override func encoding() -> ParameterEncoding {
        return URLEncoding.httpBody
    }
    
    // MARK: -公有方法
    /// 请求的数据路劲类型
    @discardableResult
    func pathRouter(_ type: RequestRouterPath) -> RosegalRouter {
        pathRouter = type
        return self
    }
    
    /// 请求的数据路劲类型
    @discardableResult
    func pathType(_ type: RouterPathType) -> RosegalRouter {
        pathType = type
        return self
    }
    
    // MARK: -URLRequestConvertible
    /**
     ** 由于各个平台的加密方式、参数拼接规则等不一致，所有需要重写该方法
    **/
    override func asURLRequest() throws -> URLRequest {
        var urlRequest = requestURL()
        urlRequest.httpMethod = httpMethod().rawValue
        
        var mParams = dicValueString(parameters)
        if isEncryption(), let paramsString = mParams {
            let key = "rosegal5"
            let iv = "lagesor8"
            // 使用AES-128-CBC加密模式
            let aes = try AES(key: key, iv: iv)
            // 开始加密
            let encrypted = try aes.encrypt(paramsString.bytes)
            // 将加密结果转成base64形式
            let encryptedBase64 = encrypted.toBase64()
            mParams = encryptedBase64
        }
        
        var postParams: [String: Any] = commomParameters()
        if let str = mParams, str.count > 0 {
            postParams["m_param"] = mParams
        }
        
        let headers = SessionManager.defaultHTTPHeaders
        urlRequest.timeoutInterval = timeoutInterval()
        urlRequest.allHTTPHeaderFields = mergeDictionary(to: headers, from: httpHeaders()) as? [String : String]
        urlRequest = try encoding().encode(urlRequest, with: postParams)
        
        return urlRequest
    }
    
    /// 字典转字符串
    func dicValueString(_ dic:[String : Any]) -> String? {
        guard dic.count > 0 else {
            return ""
        }
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
    
    /// 请求链接
    override func requestURL() -> URLRequest {
        guard let url = try? baseURLString().asURL() else {
            return URLRequest(url: URL(string: "")!)
        }
        
        if pathType.rawValue.count > 0 {
            let urlRequest = URLRequest(url: url.appendingPathComponent(pathType.rawValue))
            return urlRequest;
        }
        return URLRequest(url: url)
    }
}
