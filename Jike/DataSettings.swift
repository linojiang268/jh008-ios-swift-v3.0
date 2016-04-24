//
//  DataSettings.swift
//  Jike
//
//  Created by Iosmac on 15/6/3.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

struct DataSettings {


    static let show_msg_delay_time = 1.2//界面弹出框的延迟时间


    //性别
    enum Gender {
        case Male//男
        case Female
    }

    //根据性别的枚举值获取int值
    static func getGenderCodeByEnum(type:Gender) -> Int {
        if(type == Gender.Male) {
            return 1
        }
        return 2
    }

    //根据性别的int值获取汉语名称字符串
    static func getGenderStringByCode(code:Int) -> String {
        return code == 1 ? "男":"女"
    }

    //根据登录种类的枚举获取int
    static func getLoginTypeInt(type:LoginType) ->Int {
        if(type == LoginType.Dog) {
            return 0
        }
        else if(type == LoginType.WeChat) {
            return 1
        }
        else if(type == LoginType.FaceBook) {
            return 2
        }
        return -1
    }

    //根据登录种类的int获取枚举
    static func getLoginTypeEnum(type:Int) ->LoginType {
        if(type == 0) {
            return LoginType.Dog
        }
        else if(type == 1) {
            return LoginType.WeChat
        }
        else if(type == 2) {
            return LoginType.FaceBook
        }
        return LoginType.None
    }

    //客户端登录方式
    enum LoginType {
        case WeChat//微信
        case FaceBook//脸谱
        case Dog//邮箱
        case None
    }

}