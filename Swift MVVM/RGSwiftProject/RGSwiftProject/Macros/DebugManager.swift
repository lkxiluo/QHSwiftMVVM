//
//  DebugManager.swift
//  RGSwiftProject
//
//  Created by QianHan on 2019/8/6.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import Foundation

/// 调试管理
struct DebugManager {
    static func log<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let dateString = dateFormatter.string(from: Date())
        
        print(" ------->fileName：\(fileName)\n ------->funcName：\(funcName)\n ------->line：\(lineNum)\n ------->time：\(dateString)\n ------->content：\n\(message)")
        #endif
    }
}
