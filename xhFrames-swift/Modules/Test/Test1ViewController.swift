//
//  Test1ViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class Test1ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Test1"
        
        addLeftBarItem(title: "test1", imageName: "")
    }
    
    override func leftItemDidClicked(sender: Any) {
        let test2:Test2ViewController = Test2ViewController()
        test2.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(test2, animated: true)
    }
    
}

