//
//  ViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/10.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        log.info(kGetString(nil))
        
        BaseAPIService.sharedAPIService.request(baseUrl: nil, path: UserAPI.Login.rawValue, method: .Post, params: nil) { (result, error) in
            
            log.debug("BaseAPIService \(String(describing: result)) \(String(describing: error))")
        }
    }


}

