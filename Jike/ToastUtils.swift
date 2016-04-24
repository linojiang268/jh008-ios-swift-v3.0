//
//  ToastUtils.swift
//  Gather4
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


struct ToastUtils {
    
    static func show(msg:String?) {
        show("提示", msg: msg)
    }
    
    static func show(title:String?, msg:String?) {
        let banner = Banner(title: title, subtitle: msg, image: nil, backgroundColor: Color.red)
        banner.dismissesOnTap = true
        banner.show(duration: 1.8)
    }
}