//
//  Constants.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

struct Constants {

    static let is_release:Bool = false


    static let is_show_log:Bool = true//日志开关


    static let server_url:String = is_release ? "http://app.jh008.com" : "http://staging.jhla.com.cn"

    static let sign_key:String = is_release ? "RDPTQSUB1AKR7LO9Y17BTK2YC0PBAJ0L" : "F1C86DC81A8CBCE4EEB9D219B68D6E66"
    

    //umeng
    static let youmengId = is_release ? "55883e9b67e58e5a93003230":"55fa536667e58e7a460013e0"
    static let youmengSecret = "zkq1ldveas9w6nmolqk3a88g2gs959qv"

    static let we_chat_appid = "wx1eb81c8a7ee6f2b8"
    static let we_chat_app_secret = "f5849b1882ff66de6897a117b18ffcde"


}