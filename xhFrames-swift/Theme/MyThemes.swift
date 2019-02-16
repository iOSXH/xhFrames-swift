//
//  MyThemes.swift
//  PlistDemo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import Foundation
import SwiftTheme
import SSZipArchive

let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]

enum MyThemes: Int {
    
    case normal   = 0
    case dark = 1
    case online = 2
    
    // MARK: -
    
    static var current = MyThemes.normal
    static var before  = MyThemes.normal
    
    
    static func defaultTheme() {
        MyThemes.switchTo(.normal)
        
        // status bar
        let statusBarPick:ThemeStatusBarStylePicker = "UIStatusBarStyle"
        UIApplication.shared.theme_setStatusBarStyle(statusBarPick, animated: true)
        
        // navigation bar
        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_tintColor = "Global.barTextColor"
        navigationBar.theme_barTintColor = "Global.barTintColor"
        navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker(keyPath: "Global.barTextColor") { value -> [NSAttributedString.Key : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }
            
            let color = UIColor(rgba: rgba)
            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.shadow: shadow
            ]
            
            return titleTextAttributes
        }
        
        
        // tab bar
        let tabBar = UITabBar.appearance()
        tabBar.theme_tintColor = "Global.barTextColor"
        tabBar.theme_barTintColor = "Global.barTintColor"
    }
    
    
    // MARK: - Switch Theme
    
    static func switchTo(_ theme: MyThemes) {
        before  = current
        current = theme
        
        switch theme {
        case .normal   : ThemeManager.setTheme(plistName: "Normal", path: .mainBundle)
        case .dark : ThemeManager.setTheme(plistName: "Dark", path: .mainBundle)
        case .online  : ThemeManager.setTheme(plistName: "Blue", path: .sandbox(blueDiretory))
        }
    }
    
//    static func switchToNext() {
//        var next = current.rawValue + 1
//        var max  = 2 // without Blue and Night
//
//        if isBlueThemeExist() { max += 1 }
//        if next >= max { next = 0 }
//
//        switchTo(MyThemes(rawValue: next)!)
//    }
    
    // MARK: - Switch Night
    
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .dark : before)
    }
    
    static func isNight() -> Bool {
        return current == .dark
    }
    
    // MARK: - Download
    
    static func downloadBlueTask(_ handler: @escaping (_ isSuccess: Bool) -> Void) {
        
        let session = URLSession.shared
        let url = "https://github.com/jiecao-fm/SwiftThemeResources/blob/master/20170128/Blue.zip?raw=true"
        let URL = Foundation.URL(string: url)
        
        let task = session.downloadTask(with: URL!, completionHandler: { location, response, error in
            
            guard let location = location , error == nil else {
                DispatchQueue.main.async {
                    handler(false)
                }
                return
            }
            
            let manager = FileManager.default
            let zipPath = cachesURL.appendingPathComponent("Blue.zip")
            
            _ = try? manager.removeItem(at: zipPath)
            _ = try? manager.moveItem(at: location, to: zipPath)
            
            let isSuccess = SSZipArchive.unzipFile(atPath: zipPath.path,
                                        toDestination: unzipPath.path)
            
            DispatchQueue.main.async {
                handler(isSuccess)
            }
        }) 
        
        task.resume()
    }
    
    static func isBlueThemeExist() -> Bool {
        return FileManager.default.fileExists(atPath: blueDiretory.path)
    }
    
    static let blueDiretory : URL = unzipPath.appendingPathComponent("Blue/")
    static let unzipPath    : URL = libraryURL.appendingPathComponent("Themes/20170128")
}






enum ThememColorKey: ThemeColorPicker {
    ///
    case Global_BGC     = "Global.backgroundColor"
    case Global_GrayC     = "Global.grayColor"
    
    
    case Global_TXTC    = "Global.textColor"
}

enum ThememImageKey: ThemeImagePicker {
    ///
    case Global_Img     = "Global.image"
}
