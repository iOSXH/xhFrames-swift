//
//  AccountManager.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit

enum LoginState:Int {
    case Unknow = 0
    case In
    case Out
}

class AccountManager: NSObject {
    
    /// 用户account
    var account: AccountModel?
    
    /// 登录状态
    var loginSate :LoginState = .Unknow
    
    /// 推送设备token
    var deviceToken: String?
    
    /// 单例
    static let sharedManager:AccountManager = {
        let manager = AccountManager();
        return manager;
    }();
    
    
    /// 初始化登录状态  启动app时调用 保持登录状态
    public func initLoginState() -> Void{
        
    }
    
}
