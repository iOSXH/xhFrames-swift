//
//  BaseAPIService.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit
import Alamofire


struct APIError : Error {
    var code:Int = 0
    var domain:String = ""
    var desc:String = ""
    init(_ code:Int, _ domain:String, _ desc:String) {
        self.code = code
        self.domain = domain
        self.desc = desc
    }
}

let kHttpErrorDomain:String = "kHttpErrorDomain"
let kCustomErrorDomain:String = "kCustomErrorDomain"

enum APIMethod:Int {
    case Post = 0
    case Get = 1
}

typealias APICompleteResult = (_ result: Dictionary<String, Any>?, _ error: Error?) -> Void

class BaseAPIService: NSObject {
    
    var serviceBaseURL:String = ""
    
    var serviceSuccessCode:Int = 0
    
    typealias serviceBaseHeadersBlock = () -> Dictionary<String, String>
    
    var headerBlock:serviceBaseHeadersBlock?
    
    var serviceBaseHeaders:Dictionary<String, String>?{
        if headerBlock != nil {
            return headerBlock!()
        }else{
            return [:]
        }
    }
    
    
//    static let sharedAPIService:BaseAPIService = {
//        let service = BaseAPIService();
//        service.serviceBaseURL = DevelopMode ? kBase_Api_Url_Dev : kBase_Api_Url;
//
//        return service;
//    }();
    
    
    /// post请求
    ///
    /// - Parameters:
    ///   - path: 路由
    ///   - params: 参数
    ///   - complete: 完成回调
    func postRequest(path: String?, params: Dictionary<String, Any>?, complete: APICompleteResult?) -> Void {
        request(baseUrl: nil, path: path, method: .Post, params: params, complete: complete)
    }
    
    /// get请求
    ///
    /// - Parameters:
    ///   - path: 路由
    ///   - params: 参数
    ///   - complete: 完成回调
    func getRequest(path: String?, params: Dictionary<String, Any>?, complete: APICompleteResult?) -> Void {
        request(baseUrl: nil, path: path, method: .Get, params: params, complete: complete)
    }
    
    /// http请求
    ///
    /// - Parameters:
    ///   - baseUrl: baseUrl 可为nil
    ///   - path: path 路由path
    ///   - method: 请求方式
    ///   - params: 请求参数
    ///   - complete: 请求结果
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
        
        Alamofire.request(String(baseUrlStr), method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: serviceBaseHeaders).responseJSON(queue: nil, options: .allowFragments) { (response: DataResponse<Any>) in
            self.analysisResult(response, complete)
        }
        
    }
    
    
    
    /// 解析结果
    ///
    /// - Parameters:
    ///   - response: 结果
    ///   - complete: 解析完成
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
