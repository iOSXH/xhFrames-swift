//
//  BaseNavigationController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().shadowImage = UIImage()
        
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 1 {
            interactivePopGestureRecognizer?.isEnabled = true
        }else{
            interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override var childForStatusBarStyle: UIViewController?{
        get {
            return topViewController
        }
    }
    
    // MARK: UIViewControllerRotation
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (topViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (topViewController?.preferredInterfaceOrientationForPresentation)!
    }

    
    // MARK UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        let topVc: UIViewController? = visibleViewController
        if (topVc is BaseViewController) {
            if (topVc as? BaseViewController)?.disableSwipBack == true {
                return false
            }
        }
        return true

    }
    
    
    deinit {
        log.info("\(NSStringFromClass(type(of: self).self)) 已销毁")
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
