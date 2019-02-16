//
//  BaseTabBar.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/2/16.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import SnapKit

protocol BaseTabBarDelegate {
    func tabBarDidSelectIndex(tabBar:BaseTabBar, index:NSInteger) -> Void
}


class BaseTabBar: UITabBar {
    public
    var baseDelegate:BaseTabBarDelegate? = nil
    
    private
    let bgView:UIView = UIView()
    
    var tabBtns:NSArray = NSArray()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.frame = self.bounds;
        self.bringSubviewToFront(bgView)
    }
    
    
    func initSubViews() {
        bgView.theme_backgroundColor = ThememColorKey.Global_BGC.rawValue
        self.addSubview(bgView)
        
        
        let configs:Array = [
            ["imageText":"\u{eb8e}","titleText":"账号"],
            ["imageText":"\u{eb90}","titleText":"设置"]
        ]
        
        
        let sideSpace:CGFloat = 10
        let space:CGFloat = 10
//        let btnHeight:CGFloat = kTabBarNormalHeight
//        let btnWidth =
        
        var btnAry:Array<ConstraintView> = []
        for index in 0...configs.count-1 {
            let config:Dictionary = configs[index]
            let imageText:String? = config["imageText"]
//            let titleText:String? = config["titleText"]
            
            let preView:UIView? = btnAry.last
            
            let btn:UIButton = UIButton()
            btn.theme_setTitleColor(ThememColorKey.Global_TXTC.rawValue, forState: .normal)
            btn.titleLabel?.font = UIFont(name: kFont_Icon, size: 25)
            btn.setTitle(imageText, for: .normal)
            btn.setTitle(imageText, for: .selected)
            btn.addTarget(self, action: #selector(btnDidClicked(sender:)), for: .touchUpInside)
            bgView.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.height.equalTo(kTabBarNormalHeight)
                if preView == nil {
                    make.left.equalToSuperview().offset(sideSpace)
                }else{
                    make.left.equalTo(preView!.snp.right).offset(space)
                    make.width.equalTo(preView!)
                }
                if index == configs.count - 1 {
                    make.right.equalToSuperview().offset(sideSpace)
                }
            }
            
            btnAry.append(btn)
        }
        
    }
    
    
    @objc func btnDidClicked(sender:UIButton) -> Void {
        
    }

}
