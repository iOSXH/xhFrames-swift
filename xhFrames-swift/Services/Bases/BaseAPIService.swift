//
//  BaseAPIService.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit
import Alamofire

enum APIMethod:Int {
    case Post = 0
    case Get = 1
}

typealias APICompleteResult = (_ result: Dictionary<String, Any>?, _ error: Error?) -> Void

class BaseAPIService: NSObject {
    
    var serviceBaseURL:String = ""
    var serviceBaseHeaders:Dictionary<String, Any> = [:]
    var serviceSuccessCode:Int = 0
    
    
    
    static let sharedAPIService:BaseAPIService = {
        let service = BaseAPIService();
        service.serviceBaseURL = DevelopMode ? kBase_Api_Url_Dev : kBase_Api_Url;
        
        
        
        return service;
    }();
    
    func request(baseUrl: String?, path: String?, method: APIMethod, params: Dictionary<String, Any>?, complete: APICompleteResult?) -> Void {
        
        log.debug("请求开始\n baseUrl: \(kGetString(baseUrl)) \n path: \(kGetString(path)) \n method: \(kGetString(method)) \n params: \(kGetString(params))")
        
        var baseUrlStr:String = kEmptyString(baseUrl) ? serviceBaseURL : baseUrl ?? "";
        if kEmptyString(path) == false {
            baseUrlStr = baseUrlStr.appendingFormat("/%@", path ?? "")
        }
        
        var httpMethod:HTTPMethod = HTTPMethod.post;
        switch method {
        case .Get:
            httpMethod = HTTPMethod.get
        case .Post:
            httpMethod = HTTPMethod.post
        }
        
        Alamofire.request(String(baseUrlStr), method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(queue: nil, options: .allowFragments) { (response: DataResponse<Any>) in
            self.analysisResult(response, complete)
        }
        
    }
    
    private func analysisResult(_ response: DataResponse<Any>, _ complete: APICompleteResult?) -> Void {
        
        log.debug("请求结束\n baseUrl: \(String(describing: response.request?.url)) \n data: \(String(describing: response.data)) \n result: \(String(describing: response.value)) \n error: \(String(describing: response.error))")
        
        let resultDic:Dictionary<String, Any> = response.value as! Dictionary<String, Any>
        let errorCode:Int = resultDic["code"] as! Int
        
        if response.error != nil {
            
            var error = response.error;
            if error is AFError {
                let afEr:AFError = error as! AFError
                error = APIError.init(afEr.responseCode ?? 0, kHttpErrorDomain, afEr.localizedDescription)
            }
            if complete != nil {
                complete!(nil, error)
            }
        }else{
            if errorCode == serviceSuccessCode {
                if complete != nil {
                    complete!(resultDic, nil)
                }
            }else{
                let errorMsg:String = resultDic["message"] as! String
                let error:Error = APIError.init(errorCode, kCustomErrorDomain, errorMsg)
                if complete != nil {
                    complete!(nil, error)
                }
            }
        }
        
        
    }
    
}
