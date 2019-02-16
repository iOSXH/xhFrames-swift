//
//  BaseTabBarController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    let baseTabBar:BaseTabBar = BaseTabBar.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        baseTabBar.frame = self.tabBar.bounds
        
        self.setValue(baseTabBar, forKey: "tabBar")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
