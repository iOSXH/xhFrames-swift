//
//  AppDelegate.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/10.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit
import XCGLogger


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupThirdLibs()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    /// 设置初始化第三方库
    func setupThirdLibs(){
        
        
    }
}




/// 日志初始化
let log: XCGLogger = {
    
    let log = XCGLogger.default
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
    
    let logPath: URL = NSURL.fileURL(withPath: cachePath.appendingPathComponent("XCGLogger_Logs.txt"))
    
    
    if DebugModel == true {
        log.setup(level: .debug, showLogIdentifier: false, showFunctionName: false, showThreadName: false, showLevel: false, showFileNames: false, showLineNumbers: false, showDate: true, writeToFile: logPath, fileLevel: .debug)
    }else{
        log.setup(level: .info, showLogIdentifier: false, showFunctionName: false, showThreadName: false, showLevel: false, showFileNames: false, showLineNumbers: false, showDate: true, writeToFile: logPath, fileLevel: .info)
    }
    
    
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "①verbose🗯:\n", postfix: "\n🗯", to: .verbose)
    emojiLogFormatter.apply(prefix: "②debug🔹:\n", postfix: "\n🔹", to: .debug)
    emojiLogFormatter.apply(prefix: "③infoℹ️:\n", postfix: "\nℹ️", to: .info)
    emojiLogFormatter.apply(prefix: "④warning⚠️:\n", postfix: "\n⚠️", to: .warning)
    emojiLogFormatter.apply(prefix: "⑤error‼️:\n", postfix: "\n‼️", to: .error)
    emojiLogFormatter.apply(prefix: "⑥severe💣:\n", postfix: "\n💣", to: .severe)
    log.formatters = [emojiLogFormatter]
    
    if let fileDestination: FileDestination = log.destination(withIdentifier: XCGLogger.Constants.fileDestinationIdentifier) as? FileDestination {
        let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
        ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
        ansiColorLogFormatter.colorize(level: .debug, with: .black)
        ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
        ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
        ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
        ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
        fileDestination.formatters = [ansiColorLogFormatter]
    }
    
    // Add basic app info, version info etc, to the start of the logs
//    log.logAppDetails()
    
    
    
    return log;
}()
