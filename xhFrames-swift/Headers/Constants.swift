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
/// 是否横竖屏 用户界面横屏了才会返回YES
let IS_LANDSCAPE:Bool = UIApplication.shared.statusBarOrientation.isLandscape
/// 无论支不支持横屏，只要设备横屏了，就会返回YES
let IS_DEVICE_LANDSCAPE:Bool = UIDevice.current.orientation.isLandscape

/// 屏幕宽度 会根据横竖屏的变化而变化
let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
/// 屏幕高度 会根据横竖屏的变化而变化
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height;
/// 屏幕最长
let SCREEN_MAX_LENGTH:CGFloat = max(SCREEN_WIDTH, SCREEN_HEIGHT)
/// 屏幕最短
let SCREEN_MIN_LENGTH:CGFloat = min(SCREEN_WIDTH, SCREEN_HEIGHT)
/// 屏幕宽度，跟横竖屏无关
let DEVICE_WIDTH:CGFloat = IS_LANDSCAPE ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
/// 屏幕高度，跟横竖屏无关
let DEVICE_HEIGHT:CGFloat = IS_LANDSCAPE ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
/// 屏幕sacle
let SCREEN_SCALE:CGFloat = UIScreen.main.scale
let SCREEN_NATIVESCALE:CGFloat = UIScreen.main.nativeScale
/// 是否放大模式（iPhone 6及以上的设备支持放大模式）
let IS_ZOOMEDMODE:Bool = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeScale)) ? (SCREEN_NATIVESCALE > SCREEN_SCALE) : false

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
private var is35InchScreen: Int = -1
/// iPhone 4
var IS_35INCH_SCREEN: Bool {
    if is35InchScreen < 0 {
        let screenSizeFor35Inch = CGSize(width: 320, height: 480)
        is35InchScreen = (DEVICE_WIDTH == screenSizeFor35Inch.width && DEVICE_HEIGHT == screenSizeFor35Inch.height) ? 1 : 0
    }
    return is35InchScreen > 0
}

private var is40InchScreen: Int = -1
/// iPhone 5
var IS_40INCH_SCREEN: Bool {
    if is40InchScreen < 0 {
        let screenSizeFor40Inch = CGSize(width: 320, height: 568)
        is40InchScreen = (DEVICE_WIDTH == screenSizeFor40Inch.width && DEVICE_HEIGHT == screenSizeFor40Inch.height) ? 1 : 0
    }
    return is40InchScreen > 0
}

private var is47InchScreen: Int = -1
/// iPhone 6 7 8
var IS_47INCH_SCREEN: Bool {
    if is47InchScreen < 0 {
        let screenSizeFor47Inch = CGSize(width: 375, height: 667)
        is47InchScreen = (DEVICE_WIDTH == screenSizeFor47Inch.width && DEVICE_HEIGHT == screenSizeFor47Inch.height) ? 1 : 0
    }
    return is47InchScreen > 0
}

private var is55InchScreen: Int = -1
/// iPhone 6 7 8 Plus
var IS_55INCH_SCREEN: Bool {
    if is55InchScreen < 0 {
        let screenSizeFor55Inch = CGSize(width: 414, height: 736)
        is55InchScreen = (DEVICE_WIDTH == screenSizeFor55Inch.width && DEVICE_HEIGHT == screenSizeFor55Inch.height) ? 1 : 0
    }
    return is55InchScreen > 0
}

private var is58InchScreen: Int = -1
/// iPhone X/XS
var IS_58INCH_SCREEN: Bool {
    if is55InchScreen < 0 {
        let screenSizeFor58Inch = CGSize(width: 375, height: 812)
        is58InchScreen = (DEVICE_WIDTH == screenSizeFor58Inch.width && DEVICE_HEIGHT == screenSizeFor58Inch.height) ? 1 : 0
    }
    return is58InchScreen > 0
}

private var is61InchScreen: Int = -1
/// iPhone XR
var IS_61INCH_SCREEN: Bool {
    if is55InchScreen < 0 {
        let screenSizeFor61Inch = CGSize(width: 414, height: 896)
        is61InchScreen = (DEVICE_WIDTH == screenSizeFor61Inch.width && DEVICE_HEIGHT == screenSizeFor61Inch.height) ? 1 : 0
    }
    return is61InchScreen > 0
}

private var is65InchScreen: Int = -1
/// iPhone XS Max
var IS_65INCH_SCREEN: Bool {
    if is65InchScreen < 0 {
        let screenSizeFor65Inch = CGSize(width: 414, height: 896)
        is65InchScreen = (DEVICE_WIDTH == screenSizeFor65Inch.width && DEVICE_HEIGHT == screenSizeFor65Inch.height) ? 1 : 0
    }
    return is65InchScreen > 0
}

/// 将屏幕分为普通和紧凑两种，这个方法用于判断普通屏幕
let IS_RegularScreen:Bool = IS_IPAD || (!IS_ZOOMEDMODE && (IS_65INCH_SCREEN || IS_61INCH_SCREEN || IS_55INCH_SCREEN))

private var isNotchedScreen: Int = -1
/// 是否全面屏设备 带物理凹槽的刘海屏或者使用 Home Indicator 类型的设备
var IS_NOTCHED_SCREEN: Bool {
    if #available(iOS 11, *) {
        if isNotchedScreen < 0 {
            // iOS 12，只要 init 完 window，window 的尺寸就已经被设定为当前 App 的大小了，所以可以通过是否有 safeAreaInsets 来动态判断。
            // 但 iOS 11 及以前无法通过这个方式动态判断，所以只能依靠物理设备的判断方式
            if #available(iOS 12, *) {
                let window = UIWindow()
                isNotchedScreen = window.safeAreaInsets.bottom > 0 ? 1 : 0
            } else {
                isNotchedScreen = IS_58INCH_SCREEN ? 1 : 0
            }
        }
    } else {
        isNotchedScreen = 0
    }
    return isNotchedScreen > 0
}

/// iPhoneX 系列全面屏手机的安全区域的静态值
var safeAreaInsetsForDeviceWithNotch: UIEdgeInsets {
    if !IS_NOTCHED_SCREEN {
        return UIEdgeInsets.zero
    }
    
    if IS_IPAD {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
    
    switch orientation {
    case .portrait:
        return UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
    case .portraitUpsideDown:
        return UIEdgeInsets(top: 34, left: 0, bottom: 44, right: 0)
    case .landscapeLeft, .landscapeRight:
        return UIEdgeInsets(top: 0, left: 44, bottom: 21, right: 44)
    case .unknown:
        fallthrough
    default:
        return UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
    }
}

/// 底部高度 试用于全面屏
var kSafeAreaInsets: UIEdgeInsets {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return UIEdgeInsets.zero;
        }
        return unwrapedWindow.safeAreaInsets;
    }
    return UIEdgeInsets.zero;
}


/// 区分全面屏（iPhone X 系列）和非全面屏
func PreferredValueForNotchedDevice(_ notchedDevice:CGFloat, _ otherDevice:CGFloat) -> CGFloat{
    return IS_NOTCHED_SCREEN ? notchedDevice : otherDevice
}
/// 将所有屏幕按照宽松/紧凑分类，其中 iPad、iPhone XS Max/XR/Plus 均为宽松屏幕，但开启了放大模式的设备均会视为紧凑屏幕
func PreferredValueForVisualDevice(_ regular:CGFloat, _ compact:CGFloat) -> CGFloat{
    return IS_RegularScreen ? regular : compact
}

/// 状态栏正常高度
let kStatusBarNormalHeight:CGFloat =  UIApplication.shared.isStatusBarHidden ? (IS_IPAD ? (IS_NOTCHED_SCREEN ? 24 : 20) : PreferredValueForNotchedDevice(IS_LANDSCAPE ? 0 : 44 , 20)) : UIApplication.shared.statusBarFrame.size.height
/// 状态栏高度 (来电等情况下，状态栏高度会发生变化，所以应该实时计算)
let kStatusBarHeight:CGFloat =  UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height
/// tabbar正常高度
let kTabBarNormalHeight:CGFloat = IS_IPAD ? (IS_NOTCHED_SCREEN ? 65 : 50) : PreferredValueForNotchedDevice(IS_LANDSCAPE ? 32 : 49 , 49)
/// tabbar高度
let kTabBarHeight:CGFloat = (kTabBarNormalHeight + safeAreaInsetsForDeviceWithNotch.bottom)
/// 导航栏高度
let kNavigationBarNormalHeight:CGFloat =  IS_LANDSCAPE ? PreferredValueForVisualDevice(44, 32) : 44;
/// 导航栏加状态栏正常高度 
let kNavigationNormalHeight:CGFloat = (kNavigationBarNormalHeight + kStatusBarNormalHeight)
/// 导航栏加状态栏高度
let kNavigationHeight:CGFloat = (kNavigationBarNormalHeight + kStatusBarHeight)

/// 获取一个像素
var kPixelOne:CGFloat {
    var pixelOne: CGFloat = -1.0
    if pixelOne < 0 {
        pixelOne = 1 / UIScreen.main.scale
    }
    return pixelOne
}

/// 是否是刘海屏手机
let IS_BANGS_IPHONE:Bool = IS_NOTCHED_SCREEN;

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
