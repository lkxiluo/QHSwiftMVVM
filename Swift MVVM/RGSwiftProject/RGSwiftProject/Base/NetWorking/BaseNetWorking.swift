//
//  BaseNetWorking.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/19.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Alamofire

enum RequestPath: String {
    case home = "get_home_changle"
    case category = "cate_list"
}

class BaseNetWorking: HummerNet {
    func baseURLString() -> String {
        return "http:xxxxxx"
    }
    
    func httpMethod() -> HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    func path() -> String {
        return ""
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
}
