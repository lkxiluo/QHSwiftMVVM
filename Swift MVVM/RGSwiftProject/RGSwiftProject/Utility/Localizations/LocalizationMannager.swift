//
//  LocalizationMannager.swift
//  Zaful
//
//  Created by QianHan on 2017/12/14.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

import Foundation


/// 国际化字符串转换
///
/// - Parameter key: 要转换的键
/// - Returns: 转换后的字符串
func LocalizedString(_ key: String) -> String {
    return LocalizationMannager.share.localizedForKey(key)
}

fileprivate let kCurrentLocalized  = "kCurrentLocalized"
/// 国际化管理
final class LocalizationMannager {
    /// 当前语言编码，默认英语
    var languageCode: String = "en"
    /// 当前语言名，默认英语
    var languageName: String = "English"
    /// 是否在 app 内切换
    var isAppNative: Bool    = false
    /// APP设置支持的语言集合
    var languageList = [String]()
    
    static let share = LocalizationMannager()
    init() {
        configLanguageCode()
    }
    
    func setLanguageCode(_ code: String) {
        languageCode = code
        let userDefault = UserDefaults.standard
        userDefault.set(code, forKey: kCurrentLocalized)
    }
    
    fileprivate func localizedForKey(_ key: String) -> String {
        let bundlePath    = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle        = Bundle.init(path: bundlePath!)
        let stringInTable = NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: "")
        return stringInTable
    }
    
    /// 配置语言
    fileprivate func configLanguageCode() {
        if isSetAppNative() {
            let userDefault = UserDefaults.standard
            languageCode    = userDefault.string(forKey: kCurrentLocalized)!
        }
        nativeLanguageList()
    }
    
    /// 读取APP内适配的语言列表
    fileprivate func nativeLanguageList() {
        let fileArray          = Bundle.main.paths(forResourcesOfType: "lproj", inDirectory: nil)
        var languageArray      = [String]()
        var systemLanguageCode = String()
        if NSLocale.preferredLanguages.count > 0 {
            let language = NSLocale.preferredLanguages.first!
            let index  = language.index(language.startIndex, offsetBy: 2)
            systemLanguageCode = String(language[..<index])
        } else {
            systemLanguageCode = NSLocale.current.currencyCode!
        }
        
        var isExit = false
        for fileName in fileArray {
            let index1   = fileName.index(fileName.endIndex, offsetBy: -8)
            let index2   = fileName.index(fileName.endIndex, offsetBy: -6)
            let langCode = String(fileName[index1..<index2])
            if langCode == systemLanguageCode {
                isExit = true
            }
            languageArray.append(langCode)
        }
        
        if !isSetAppNative() {
            languageCode = isExit ? systemLanguageCode : languageCode
        }
        languageList = languageArray
    }
    
    fileprivate func isSetAppNative() -> Bool {
        let userDefault = UserDefaults.standard
        return (userDefault.string(forKey: kCurrentLocalized) != nil && isAppNative)
    }
}
