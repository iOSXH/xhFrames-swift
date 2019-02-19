//
//  BaseViewController.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import KMNavigationBarTransition

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
    var navBgThemeColorKey:ThememColorKey? = ThememColorKey.Global_BGC{
        didSet{
            if oldValue == navBgThemeColorKey{
                return
            }
            
            if navigationController == nil {
                return
            }
            
            if navBgThemeColorKey != nil {
//                let img:UIImage = UIImage.i
                
            }else{
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            }
            
        }
    }
    

    // MARK:- 生命周期_lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.theme_backgroundColor = ThememColorKey.Global_GrayC.rawValue
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
    func leftItemDidClicked(sender:Any) -> Void {
        
    }
    /// 导航栏右边按钮点击事件  子类继承
    func rightItemDidClicked(sender:Any) -> Void {
        
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
