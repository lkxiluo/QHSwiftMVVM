//
//  CacheManager.swift
//  RGSwiftProject
//
//  Created by lkun on 2019/8/21.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation
import Cache

/// 将参数、url 进行 MD5 加密作为缓存的键，即请求的可唯一标识加密成缓存关键字
func cacheKey(url: String, parameters: Dictionary<String, Any>?, commomParameters:Dictionary<String, Any>?) -> String {
    var resultKey: String = ""
    if let params = parameters?.filter({ (key, _) -> Bool in
        return commomParameters?.contains(where: { (key1, _) -> Bool in return key != key1 }) ?? false }) {
        let str = "\(url)" + sort(parameters: params)
        resultKey = MD5(str)
    } else {
        resultKey = MD5(url)
    }
    return resultKey
}

/// 将参数降序转成字符串
func sort(parameters: Dictionary<String, Any>?) -> String {
    var result: String = ""
    if let params = parameters {
        let sortKeyArray = params.keys.sorted{ $0 < $1}
        sortKeyArray.forEach { (key) in
            if let value = params[key] {
               result = result.appending("\(key)=\(value)")
            } else {
                result = result.appending("\(key)=")
            }
        }
    }
    return result
}

// MARK: 缓存过期参数
enum CacheExpiry {
    /// 永不过期（68 年），见 Expiry.never
    case never
    /// 设置多少秒后过期
    case seconds(TimeInterval)
    /// 到哪个日期过期
    case date(Date)
    
    /// Cache 的过期对象
    public var expired: Expiry {
        switch self {
        case .never:
            return Expiry.never
        case .seconds(let time):
            return Expiry.seconds(time)
        case .date(let data):
            return Expiry.date(data)
        }
    }
    
    /// 根据到期日期检查缓存对象是否过期
    public var isExpired: Bool {
        return expired.isExpired
    }
}

// MARK: 缓存的对象模型
struct CacheModel: Codable {
    var data: Data?
    var response: Dictionary<String, Data>?
    init() { }
}

// MARK: 缓存管理器
class CacheManager: NSObject {
    static let `default` = CacheManager()
    // Storage 
    private var storage: Storage<CacheModel>?
    var expired: CacheExpiry = .never
    override init() {
        super.init()
        config()
    }
    
    func config(expired: CacheExpiry = .never) {
        self.expired = expired
        let diskConfig = DiskConfig(name: "HummerCache", expiry: expired.expired)
        let memoryConfig = MemoryConfig(expiry: expired.expired)
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: CacheModel.self))
        } catch {
            DebugManager.log(error)
        }
    }
    
    /// 设置缓存，异步
    func setObject(object: CacheModel, for key: String) {
        storage?.async.setObject(object, forKey: key, completion: { (result) in
            switch result {
            case .value(let obj):
                DebugManager.log("缓存成功：\(obj)")
                break
            case .error(let error):
                DebugManager.log("缓存失败：\(error)")
                break
            }
        })
    }
    
    /// 读取缓存数据，同步
    func cacheObject(for key: String) -> CacheModel? {
        do {
            // 当缓存过期时清除
            if let isExpiry = try storage?.isExpiredObject(forKey: key), isExpiry {
                removeObject(for: key) { (_) in }
                return nil
            } else {
                return (try storage?.object(forKey: key)) ?? nil
            }
        } catch {
            return nil
        }
    }
    
    /// 根据键移除缓存
    func removeObject(for key: String, completeHandle:@escaping (_ isSuccess: Bool) -> Void) {
        storage?.async.removeObject(forKey: key, completion: { (result) in
            switch result {
            case .value(_): completeHandle(true)
            case .error(_): completeHandle(false)
            }
        })
    }
    
    /// 移除所有缓存
    func removeAllObject(completeHandle:@escaping (_ isSuccess: Bool) -> Void) {
        storage?.async.removeAll(completion: { (result) in
            switch result {
            case .value(_): completeHandle(true)
            case .error(_): completeHandle(false)
            }
        })
    }
}
