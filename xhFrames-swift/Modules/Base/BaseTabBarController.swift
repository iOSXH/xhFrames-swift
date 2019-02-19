//
//  BaseTabBarController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController, BaseTabBarDelegate {
    
    let baseTabBar:BaseTabBar = BaseTabBar.init()
    
    var currentNavigationController:UINavigationController?{
        get {
            let vc: UIViewController? = selectedViewController
            if (vc is UINavigationController) {
                return vc as? UINavigationController
            } else {
                return nil
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        baseTabBar.frame = self.tabBar.bounds
        baseTabBar.baseDelegate = self
        self.setValue(baseTabBar, forKey: "tabBar")
    }
    
    // MARK: 代理BaseTabBarDelegate
    func tabBarDidSelectIndex(tabBar: BaseTabBar, index: NSInteger) {
        if selectedIndex == index {
            return
        }
        
        selectedIndex = index
    }
    
    
    // MARK: getter/setter
    override var childForStatusBarStyle: UIViewController?{
        get {
            return selectedViewController
        }
    }
    override var childForStatusBarHidden: UIViewController?{
        get {
            return selectedViewController
        }
    }
    
    // MARK: UIViewControllerRotation
    override var shouldAutorotate: Bool {
        return selectedViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (selectedViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (selectedViewController?.preferredInterfaceOrientationForPresentation)!
    }


}
