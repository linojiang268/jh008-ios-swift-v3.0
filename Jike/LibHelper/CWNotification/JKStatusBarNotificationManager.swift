//
//  JKStatusBarNotificationManager.swift
//  Jike
//
//  Created by jsonmess on 15/7/20.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
/// 对CWStatusBarNotification进行封装
class JKStatusBarNotificationManager: NSObject {
 
    var statusBarNotification :CWStatusBarNotification!
    
    override init()
    {
        super.init()
        statusBarNotification = CWStatusBarNotification()
        self.statusBarNotification.notificationLabelBackgroundColor = UIColor.blackColor()
        //默认状态是从顶部出现，从顶部消失
        self.statusBarNotification.notificationAnimationInStyle = CWNotificationAnimationStyle.Top
        self.statusBarNotification.notificationAnimationOutStyle = CWNotificationAnimationStyle.Top
        //默认是状态栏通知
        self.statusBarNotification.notificationStyle = CWNotificationStyle.StatusBarNotification
    }
    /**
    开始显示状态栏通知
    - parameter message:  信息
    - parameter duration: 显示时长，
    */
    func beginShowNotification(message:String,duration:NSTimeInterval)
    {
        self.statusBarNotification.displayNotificationWithMessage(message, forDuration: duration)
    }
    /**
    显示状态栏通知---不限时长，需要手动dismiss
    - parameter message: 消息
    */
    func beginShowNotification(msg:String)
    {
        self.statusBarNotification.notificationLabelBackgroundColor = UIColor.blackColor()
        self.statusBarNotification.displayNotificationWithMessage(msg, completion: nil)
    }
    /**
      状态栏通知消失
    */
    func dismissShowNotification()
    {
        self.statusBarNotification.dismissNotification()
    }
    /**
        测试状态栏通知 --请忽略 O(∩_∩)O~~
    */
    static func testThenNotification()
    {
        let notificaiton = JKStatusBarNotificationManager()
        notificaiton.beginShowNotification("状态栏消息测试", duration: 2.0)
    }
}
