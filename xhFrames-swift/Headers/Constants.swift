//
//  Constants.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/10.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit


//MARK: 系统相关
/// iOS系统版本
let IOS_VERSION:Float = Float(UIDevice.current.systemVersion) ?? 0.0

//MARK: 机型相关
/// 是否是模拟器
let IS_SIMULATOR = TARGET_IPHONE_SIMULATOR
/// 是否是iPad
let IS_IPAD:Bool = (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.pad)
/// 是否是iPhone
let IS_IPHONE:Bool = (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiom.phone)
/// 是否是retina屏幕
let IS_RETINA:Bool = (UIScreen.main.scale >= 2.0)

//MARK: 屏幕相关
/// 屏幕宽度
let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
/// 屏幕高度
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height;
/// 屏幕最长
let SCREEN_MAX_LENGTH:CGFloat = max(SCREEN_WIDTH, SCREEN_HEIGHT)
/// 屏幕最短
let SCREEN_MIN_LENGTH:CGFloat = min(SCREEN_WIDTH, SCREEN_HEIGHT)

//MARK: 工程相关
/// 工程info字典
let kMainBundleInfo:[String : Any] = Bundle.main.infoDictionary ?? ["":""]
/// APP名称
let kAPPName:String = kMainBundleInfo["CFBundleDisplayName"] as! String
/// 工程名称
let kAPPBundleName:String = kMainBundleInfo[kCFBundleExecutableKey as String] as! String
/// APP版本号
let kAPPVersion:String = kMainBundleInfo["CFBundleShortVersionString"] as! String
/// APP构建版本号
let kAPPBuild:String = kMainBundleInfo["CFBundleVersion"] as! String
/// APPBundleId
let kAPPBundleIdentifier:String = Bundle.main.bundleIdentifier ?? ""
/// APPIcon路径
let kAPPIconPath:String = (kMainBundleInfo["CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] as! NSArray).lastObject as! String
/// APPIcon
let kAPPIcon:UIImage = UIImage.init(named: kAPPIconPath) ?? UIImage.init()

//MARK: 适配相关
/// 状态栏高度
let kStatusBarHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 底部高度 试用于全面屏
var kBottomSafeHeight: CGFloat {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return 0.0
        }
        return unwrapedWindow.safeAreaInsets.bottom;
    }
    return 0.0
}
/// tabbar正常高度
let kTabBarNormalHeight:CGFloat = 49.0
/// tabbar高度
let kTabBarHeight:CGFloat = (kBottomSafeHeight + kTabBarNormalHeight)
/// 导航栏高度
let kNavigationBarNormalHeight:CGFloat = 44.0;
/// 导航栏加状态栏高度
let kNavigationBarHeight:CGFloat = (kNavigationBarNormalHeight + kStatusBarHeight)

/// 是否是刘海屏手机
let IS_BANGS_IPHONE:Bool = kBottomSafeHeight > 0.0;

/// 缩放比例
let kScale:CGFloat = (SCREEN_WIDTH/375.0)
let kIpadScale:CGFloat = (IS_IPAD ? 1.0 : kScale)

let kMinScale:CGFloat = (SCREEN_MIN_LENGTH/375.0)
let kIPadMinScale:CGFloat = (IS_IPAD ? 1 : kMinScale)

//MARK: 方法相关
/// 获取图片
func kImageNamed(_ name: String) -> UIImage {
    return UIImage.init(named: name) ?? UIImage.init()
}
/// 从Bundle获取图片
func kImageFromBundle(_ resource: String) -> UIImage {
    let path:String = Bundle.main.path(forResource: resource, ofType: "") ?? ""
    return UIImage.init(contentsOfFile: path) ?? UIImage.init()
}
/// 获取字体
func kFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}
func kBoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}
// 适配间距
func kSize(_ size: CGFloat, _ adjustIpad: Bool) -> CGFloat {
    return size * (adjustIpad ? kIPadMinScale : kMinScale)
}
// 字符串是否为空
func kEmptyString(_ string: Any?) -> Bool {
    if string == nil{
        return true
    }
    
    if string is String {
        let str:String = string as! String
        return str.count <= 0
    }else if string is NSString {
        let str:NSString = string as! NSString
        return str.length <= 0
    }
    return false
}

/// 获取字符串
func kGetString(_ string: Any?) -> String {
    if string is String {
        let str:String = string as! String
        return str
    }else if string is NSNull{
        return ""
    }else if string is NSNumber{
        let numer:NSNumber = string as! NSNumber;
        return String.init(format: "%@", numer)
    }
    else{
        return String(describing: string)
    }
}

//func kError(_ code: NSInteger, _ dimain: String, _ msg: NSString) -> NSError {
//    let error:NSError = NSError.init(domain: <#T##String#>, code: <#T##Int#>, userInfo: <#T##[String : Any]?#>)
//    
//}
