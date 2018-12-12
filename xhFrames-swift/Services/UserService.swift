//
//  UserService.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit

class UserService: NSObject {
    static let UserAPIService:BaseAPIService = {
        let service = BaseAPIService();
        service.serviceBaseURL = DevelopMode ? kBase_Api_Url_Dev : kBase_Api_Url;
        service.serviceSuccessCode = 0
        service.headerBlock = {
            () in
            return [:]
        }
        return service;
    }();
    
    func loginWithWechat() -> Void {
        
    }
    
}
