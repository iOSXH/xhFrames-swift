//
//  BaseExtensions.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/1/5.
//  Copyright © 2019 xianghui. All rights reserved.
//

import Foundation

// MARK: - 字典扩展
extension Dictionary{
    
    
    
    
    
//#if DebugMode
//    public var description: String {
//        get{
//            return "2123"
//        }
//    }
//    public var debugDescription: String {
//        get{
//            return "2123"
//        }
//    }
//#endif
}

// MARK: - 字符串扩展
extension String{
    
    /// 生成随机字符串
    ///
    /// - Parameter length: 字符串长度
    /// - Returns: 随机字符串
    static func randomString(length: Int) -> String{
        let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString: String = ""
        for _ in 0...length {
            let str: Character? = letters.randomElement()
            randomString = randomString.appending(String(str ?? "a"))
        }
        return randomString
    }
    
    /// 小写随机字符串
    ///
    /// - Parameter length: 长度
    /// - Returns: 字符串
    static func randomSmallString(length: Int) -> String{
        let letters: String = "abcdefghijklmnopqrstuvwxyz0123456789"
        
        var randomString: String = ""
        for _ in 0...length {
            let str: Character? = letters.randomElement()
            randomString = randomString.appending(String(str ?? "a"))
        }
        return randomString
    }
    
    /// 字符串提取数字
    ///
    /// - Returns: 数字字符串
    public func numberString() ->String {
        
        var numStr = ""
        if count > 0 {
            let nonDigitCharacterSet = CharacterSet.decimalDigits.inverted
            numStr = components(separatedBy: nonDigitCharacterSet).joined(separator: "")
        }
        
        return numStr
    }
    
    
    /// 手机号码格式化
    ///
    /// - Returns: 手机号字符串
    public func phoneNumberFormat() -> String {
        let numStr = numberString()
        if numStr.count > 11 {
            return numStr
        }
        
        var phoneNumStr = ""
        var index: Int = 0
        var stop = false
        while !stop {
            let length: Int = index > 0 ? 4 : 3
            var subStr = ""
            
            if numStr.count <= index + length {
                subStr = (numStr as NSString).substring(with: NSRange(location: index, length: numStr.count - index))
                stop = true
            } else {
                subStr = (numStr as NSString).substring(with: NSRange(location: index, length: length))
            }
            
            if phoneNumStr.count <= 0 {
                phoneNumStr = phoneNumStr + (subStr)
            } else {
                phoneNumStr = phoneNumStr + ("-\(subStr)")
            }
            index += subStr.count
        }
        
        return phoneNumStr
    }
    
    /// 字符串转URL
    ///
    /// - Returns: url
    public func kURL() -> URL? {
        var url = URL(string: self)
        if url == nil {
            let encodedURLString = addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            url = URL(string: encodedURLString ?? "")
        }
        return url
    }
    
    /// 字符串文本长度 英文1 中文 2
    ///
    /// - Returns: 长度
//    public func textLength() -> Int {
    
//        var asciiLength: Int = 0
//
//        for i in 0..<count {
//
//            let uc:Character = self[self.index(self.startIndex, offsetBy: i)]
//            let isascii:Bool = uc.unicodeScalars.re
//            asciiLength += isascii(uc) ? 1 : 2
//        }
        
//        let unicodeLength: Int = 
        
//        return unicodeLength
//    }
    
}
