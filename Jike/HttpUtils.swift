//
//  HttpUtils.swift
//  Jike
//
//  Created by Iosmac on 15/7/27.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

struct HttpUtils {

    static func getDevice() -> String {

        let device = DataUtils.getJsonStringByDic(["app_ver": getAppVersion(),
                                                    "channel": "AppStore",
                                                    "did": DataUtils.getDeviceId(),
                                                    "model": UIDevice.currentDevice().model,
                                                    "sys_ver": UIDevice.currentDevice().systemVersion,
                                                    "platform": 2])
        return device
    }

    static func getAppVersion() -> AnyObject {

        let appVer: NSString? = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? NSString
        
        return appVer != nil ? appVer! : ""
    }
}