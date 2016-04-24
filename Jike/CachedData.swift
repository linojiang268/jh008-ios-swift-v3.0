//
//  CachedData.swift
//  Jike
//
//  Created by Iosmac on 15/4/30.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation



struct CachedData {


    static let key_user_logined_info_cached = "key_user_logined_info_cached"

    static let key_is_first_time_open_app = "key_is_first_time_open_app"

    static let key_is_user_log_out = "key_is_user_log_out"


    //是否是第一次打开应用
    static func isFirstTimeOpenApp() -> Bool {
        return getLocalData(key_is_first_time_open_app) == nil
    }

    //设置应用第一次已经打开
    static func setAppOpend() {
        saveLocalData(key_is_first_time_open_app, value: 1)
    }

    //是否已登录
    static func isUserLogined() -> Bool {
        return getLocalData(key_user_logined_info_cached) != nil && !isLogOut()
    }

    //设置应用登出状态
    static func setLogOut(isLogOut:Bool) {
        saveLocalData(key_is_user_log_out, value: isLogOut)
    }

    //判断是否已登出
    static func isLogOut() -> Bool {
        let saved: AnyObject? = getLocalData(key_is_user_log_out)
        return saved != nil && (saved as! Bool)
    }
    
    static func saveLocalData(key: String, value:AnyObject?) {
        let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        data.setObject(value, forKey: key)
    }
    
    static func getLocalData(key: String) -> AnyObject? {
        let data:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return data.objectForKey(key)
    }
}