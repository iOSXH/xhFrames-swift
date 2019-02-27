//
//  MainTabBarController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class MainTabBarController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let test1Vc = Test1ViewController()
        let test1Nav = BaseNavigationController(rootViewController: test1Vc)
        test1Vc.tabBarItem.title = ""
        
        let test2Vc = Test2ViewController()
        let test2Nav = BaseNavigationController(rootViewController: test2Vc)
        test2Vc.tabBarItem.title = ""
        
        
        let testLVc = TestListViewController()
        let testLNav = BaseNavigationController(rootViewController: testLVc)
        testLVc.tabBarItem.title = ""
        
        viewControllers = [test1Nav, testLNav, test2Nav]
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
