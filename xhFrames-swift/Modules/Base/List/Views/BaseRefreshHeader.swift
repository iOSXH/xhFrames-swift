//
//  BaseRefreshHeader.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2019/3/1.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit
import MJRefresh
import Lottie

class BaseRefreshHeader: MJRefreshHeader {
    
    var topBgView: UIView = UIView()
    var refreshView: LOTAnimationView = LOTAnimationView(name: "refresh")
    var refreshPullView: LOTAnimationView = LOTAnimationView(name: "refresh_pull")
    var refreshLab: UILabel = UILabel()

    
    override func prepare() {
        super.prepare()
        mj_h = 50
        theme_backgroundColor = ThemeColorKey.Global_GrayC.rawValue
        
        topBgView.theme_backgroundColor = ThemeColorKey.Global_GrayC.rawValue
        addSubview(topBgView)
        
        refreshView.loopAnimation = true
        addSubview(refreshView)
        
        addSubview(refreshPullView)
        
        refreshLab.theme_textColor = ThemeColorKey.Global_TXTC.rawValue
        refreshLab.font = kFont(11)
        refreshLab.textAlignment = .center
        addSubview(refreshLab)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        refreshPullView.frame = CGRect(x: mj_w/2 - 25/2, y: 8, width: 25, height: 25)
        refreshView.frame = refreshPullView.frame
        refreshLab.frame = CGRect(x: 0, y: 34, width: mj_w, height: 16)
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
        
        var dif:CGFloat = -scrollView.mj_offsetY - mj_h
        if dif < 0 {
            dif = 0
        }
        topBgView.frame = CGRect(x: 0, y: -dif, width: mj_w, height: dif)
    }
    
    override var state: MJRefreshState{
        didSet{
            switch state {
            case .idle:
                refreshPullView.isHidden = false
                refreshView.isHidden = true
                if refreshView.isAnimationPlaying {
                    refreshView.stop()
                }
                refreshLab.text = "下拉刷新"
            case .pulling:
                refreshPullView.isHidden = true
                refreshView.isHidden = false
                if !refreshView.isAnimationPlaying {
                    refreshView.play()
                }
                refreshLab.text = "松开刷新"
            case .refreshing:
                refreshPullView.isHidden = true
                if refreshPullView.isAnimationPlaying {
                    refreshPullView.stop()
                }
                refreshView.isHidden = false
                if !refreshView.isAnimationPlaying {
                    refreshView.play()
                }
                refreshLab.text = "刷新中..."
            default:
                break
            }
        }
    }
    
    override var pullingPercent: CGFloat{
        didSet{
            if !refreshPullView.isHidden {
                
                var progress: CGFloat = pullingPercent
                if progress < 0 {
                    progress = 0
                } else if progress > 1 {
                    progress = 1
                }
                
                refreshPullView.animationProgress = progress
            }
        }
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
