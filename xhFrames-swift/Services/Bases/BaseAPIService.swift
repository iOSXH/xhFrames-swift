//
//  BaseAPIService.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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

class APIResult : NSObject {
    var code:Int? = 0
    var msg:String? = ""
    var data:JSON? = nil
    
    class func jsonModel(_ data:Data?) -> APIResult {
        
        let apiResult:APIResult = APIResult.init()
        apiResult.code = -1
        apiResult.msg = "no data"
        
        if data != nil{
            do {
                let json = try JSON(data: data!)
                apiResult.code = json["code"].int
                apiResult.msg = json["message"].string
                apiResult.data = json["data"]
            } catch {
                
            }
        }
        
        return apiResult
        
    }
}

let kHttpErrorDomain:String = "kHttpErrorDomain"
let kCustomErrorDomain:String = "kCustomErrorDomain"

enum APIMethod:Int {
    case Post = 0
    case Get = 1
}

typealias APICompleteResult = (_ result: APIResult?, _ error: APIError?) -> Void

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
        
        log.debug("请求结束\n baseUrl: \(String(describing: response.request?.url)) \n data: \(String(describing: response.data)) \n result: \(String(describing: response.value)) \n error: \(kGetString(response.error))")
        
        
        if response.error != nil {
            
            var error:APIError? = nil;
            if response.error is AFError {
                let afEr:AFError = response.error as! AFError
                error = APIError.init(afEr.responseCode ?? 0, kHttpErrorDomain, afEr.localizedDescription)
            }else{
                error = APIError.init(0, kHttpErrorDomain, "")
            }
            if complete != nil {
                complete!(nil, error)
            }
        }else{
            
//
//            let jsonObject = JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
//
            let apiResult:APIResult = APIResult.jsonModel(response.data)
            
            if apiResult.code == serviceSuccessCode {
                if complete != nil {
                    complete!(apiResult, nil)
                }
            }else{
                let errorMsg:String = apiResult.msg == nil ? "" : apiResult.msg!
                let error:APIError = APIError.init(apiResult.code == nil ? 0 : apiResult.code!, kCustomErrorDomain, errorMsg)
                if complete != nil {
                    complete!(nil, error)
                }
            }
        }
    }
    
}
