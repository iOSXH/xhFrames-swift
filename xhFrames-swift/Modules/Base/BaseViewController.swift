//
//  BaseViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import KMNavigationBarTransition
import Kingfisher

class BaseViewController: UIViewController {
    
    /// 禁止手势返回
    var disableSwipBack:Bool = false
    /// 导航栏是否隐藏
    var navBarHidden:Bool = false
    /// 禁止页面统计
    var disablePageLog:Bool = false
    /// 页面第一次调用didAppear时回调
    var viewFirstAppearBlock: (() -> Void)? = nil
    
    /// 导航栏背景色 nil时透明
    var navBgThemeColorKey:ThemeColorKey?{
        didSet{
            if oldValue == navBgThemeColorKey{
                return
            }
            
            if navigationController == nil {
                return
            }
            
            navigationController?.navigationBar.theme_barTintColor = navBgThemeColorKey?.rawValue
            if navBgThemeColorKey == nil {
                navigationController?.navigationBar.theme_barTintColor = nil;
//                navigationController?.navigationBar.barTintColor = UIColor.clear;
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            }else{
                navigationController?.navigationBar.theme_barTintColor = navBgThemeColorKey?.rawValue
            }
            
        }
    }
    
    /// 导航栏标题色 nil时透明
    var navTitleThemeColorKey:ThemeTitleKey?{
        didSet{
            if oldValue == navTitleThemeColorKey{
                return
            }
            
            if navigationController == nil {
                return
            }
            navigationController?.navigationBar.theme_titleTextAttributes = NavTitleTheme(navTitleThemeColorKey!)
        }
    }
    
    deinit {
        log.info("\(NSStringFromClass(type(of: self).self)) 已销毁")
    }

    // MARK:- 生命周期_lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.theme_backgroundColor = ThemeColorKey.Global_GrayC.rawValue
        navBgThemeColorKey = ThemeColorKey.Global_BGC
        navTitleThemeColorKey = ThemeTitleKey.normal
        
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            addLeftBarItem(title: "", imageName: "icon_nav_back")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(navBarHidden, animated: animated)
        
        if viewFirstAppearBlock != nil {
            viewFirstAppearBlock!()
            viewFirstAppearBlock = nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK:- 界面旋转_UIViewControllerRotation
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        let option:UIInterfaceOrientation = [.portrait | .landscapeLeft, .landscapeRight]
//        return option
//    }

    
    
    // MARK: - 共用方法，可子类继承
    /// 页面刷新
    func refresh() -> Void {
        
    }
    /// 导航栏左边按钮点击事件  子类继承  默认pop
    @objc func leftItemDidClicked(sender:Any) -> Void {
        navigationController?.popViewController(animated: true)
    }
    /// 导航栏右边按钮点击事件  子类继承
    @objc func rightItemDidClicked(sender:Any) -> Void {
        
    }
    
    func addLeftBarItem(title: String, imageName: String) -> Void {
        addBarItem(title: title, imageName: imageName, isLeft: true)
    }
    func addRightBarItem(title: String, imageName: String) -> Void {
        addBarItem(title: title, imageName: imageName, isLeft: false)
    }
    
    
    
    // MARK: - 私有方法
    
    /// 设置左右导航栏按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - imageName: 图片名
    ///   - isLeft: 左右
    private func addBarItem(title: String, imageName: String, isLeft: Bool) -> Void {
        let action: Selector = isLeft ? (#selector(leftItemDidClicked(sender:))) : (#selector(rightItemDidClicked(sender:)))
        
        var barItem:UIBarButtonItem? = nil
        if !kEmptyString(title) {
            barItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: action)
            barItem?.theme_setTitleTextAttributes(NavBarItemTheme(.normal), forState: .normal)
            barItem?.theme_setTitleTextAttributes(NavBarItemTheme(.normal), forState: .highlighted)
        }else if (!kEmptyString(imageName)){
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            if imageName.hasPrefix("http") || imageName.hasPrefix("https") {
                btn.kf.setImage(with: URL(string: imageName), for: .normal)
            } else {
                btn.setImage(kImageNamed(imageName), for: .normal)
            }
            btn.imageEdgeInsets = isLeft ? UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
            btn.addTarget(self, action: action, for: .touchUpInside)
            barItem = UIBarButtonItem(customView: btn)
        }
        
        if isLeft {
            navigationItem.leftBarButtonItem = barItem
        }else {
            navigationItem.rightBarButtonItem = barItem
        }
        
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
