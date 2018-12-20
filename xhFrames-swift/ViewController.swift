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
        
        UserService.loginWithWechat(success: { (msg) in
            log.info("\(kGetString(msg))")
        }) { (error) in
            log.info("\(kGetString(error))")
        }
    }


}

