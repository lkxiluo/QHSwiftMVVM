//
//  Hummer.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/6.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

class Hummer: URLRequestConvertible, RequestConfigProtocol {
    var requestArray: [DataRequest] = [DataRequest]()
    func request() -> Void {
        let request = Alamofire.request(self)
        request.responseJSON { (responseJson) in
            
        }
        
    }
    
    // MARK: -URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString().asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path()))
        urlRequest.httpMethod = httpMethod().rawValue
        
        let headers = SessionManager.defaultHTTPHeaders
        urlRequest.allHTTPHeaderFields = httpHeaders()
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters())
        
        return urlRequest
    }
}
