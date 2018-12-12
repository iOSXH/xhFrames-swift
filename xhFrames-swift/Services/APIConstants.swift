//
//  APIConstants.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import Foundation


/// API地址
let kBase_Api_Url:String = "https://passport.tigerobo.com/api"
let kBase_Api_Url_Dev:String = "http://40.73.67.202"

/// API Path
enum UserAPI:String {
    /// 发送短信验证码
    case SendMsgCode = "SendConfirmationCode"
    /// 用户微信登录
    case Login = "Login"
}

