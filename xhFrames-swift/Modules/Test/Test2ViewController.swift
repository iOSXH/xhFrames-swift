//
//  Test2ViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class Test2ViewController: BaseViewController {
    
    var cnt:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Test2"
//        navBgThemeColorKey = nil;
//        navBarHidden = true
        navBgThemeColorKey = ThemeColorKey.Global_RedC
        navTitleThemeColorKey = ThemeTitleKey.other
        
        
        let barItem = UIBarButtonItem.init(title: "test222", style: .plain, target: self, action: #selector(rightItemDidClicked(sender:)))
        
        
        navigationController?.navigationItem.rightBarButtonItem = barItem
        
        
        test(1) { (a:[Any]?, b:String?) in
            self.cnt = a?.count ?? -1
            print(a ?? "")
            print(b ?? "")
            print(self.cnt)
        }
    }
    
    
    func test(_ a:Int , _ block: successBlock?) -> Void {
        if block != nil {
            block!([a, a], "bbbb")
        }
    }
}
