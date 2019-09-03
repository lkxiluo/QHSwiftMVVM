//
//  BaseNetWorking.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

class RosegalURLRequest: HummerURLRequest {
    private var pathType: RequestPathType = .default
    func baseURLString() -> String {
        return "http:xxxxxx"
    }
    
    func httpMethod() -> HTTPMethod {
        switch pathType {
        default:
            return .post
        }
    }
    
    func path() -> String {
        return pathType.rawValue
    }
    
    func commomParameters() -> [String: Any] {
        return [:]
    }
    
    func isEncryption() -> Bool {
        return true
    }
    
    func isCacheResponse() -> Bool {
        return false
    }
    
    func pathType(type: RequestPathType) -> RosegalURLRequest {
        pathType = type
        return self
    }
}
