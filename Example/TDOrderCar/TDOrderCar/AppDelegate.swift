//
//  AppDelegate.swift
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/10/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import Bugly
import MSAPM
import MSAPMDebugTool
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /// 静态变量
    private let appId = "bae1168357"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = BuglyConfig()
        // APP版本
        config.version = "1.0.4"
        // 机器码
        config.deviceIdentifier = "c14fdc7c7d8c92a224b27d4c8edc21fc5af9c6ab"
        //渠道
        config.channel = "guoxiaoliangtest"
        config.debugMode = true
        // 卡顿监控开关
        config.blockMonitorEnable = true
        // 非正常退出事件记录
        config.unexpectedTerminatingDetectionEnable = true
        // 卡顿监控判断间隔
        config.blockMonitorTimeout = 1
        Bugly.start(withAppId: appId, config: config)
        MSAPMManager.sharedInstance().startToCollectPerformanceData()
    
    
       MSAPMDebugTool.shared.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       // MSAPMManager.sharedInstance().stopUploadResourceData()
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


}

