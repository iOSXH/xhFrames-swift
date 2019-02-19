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
        
        
        let font = UIFont(name: "iconfont", size: 20)
        
        let lab:UILabel = UILabel(frame: CGRect(x: 110, y: 110, width: 100, height: 100))
        lab.font = font
        lab.text = "\u{eb8e}"
        view.addSubview(lab)
        

    }
}
