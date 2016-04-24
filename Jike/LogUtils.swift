//
//  LogUtils.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

struct  LogUtils
{

    static func log(data:AnyObject?) {
        if(Constants.is_show_log && data != nil) {
            print(data!, terminator: "")
            print("\n", terminator: "")
        }
    }
    
    static func logWidthHeight(tag:String?, view:UIView?) {
        if(Constants.is_show_log) {
            print("\(tag):view:width=\(view?.frame.width),height=\(view?.frame.height)\n", terminator: "")
        }
    }
}