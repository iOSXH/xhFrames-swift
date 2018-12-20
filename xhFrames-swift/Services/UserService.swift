//
//  UserService.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit

class UserService: NSObject {
    static let APIService:BaseAPIService = {
        let service = BaseAPIService();
        service.serviceBaseURL = DevelopMode ? kBase_Api_Url_Dev : kBase_Api_Url;
        service.serviceSuccessCode = 0
        service.headerBlock = {
            () in
            return [:]
        }
        return service;
    }();
    
    
    
    
    class func loginWithWechat(success:(_ msg: String?) -> Void, failure:(_ error: Error?) -> Void) -> Void {
        UserService.APIService.postRequest(path: UserAPI.Login.rawValue, params: nil) { (result:APIResult?, error:APIError?) in
            
        }
    }
    
}
