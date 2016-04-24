//
//  HttpParams.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

class HttpParams {
    
    private var dicUrlParam = NSMutableDictionary()

    init() {
        
    }

    private func addUrlParam(key:String, value:AnyObject) {
        dicUrlParam.setValue(value, forKey: key)
    }

    func addParam(key:String, value:AnyObject) {
        dicUrlParam.setValue(value, forKey: key)
    }
    
    func getParamDictionary() -> NSDictionary {
        return dicUrlParam
    }
    
    func getParamString() -> String {
        var urlParam:String = "?"
        var index = 0
        for (key, value) in dicUrlParam {
            index++
            urlParam = urlParam+"\(key)=\(value)"
            if(index < dicUrlParam.count) {
                urlParam = urlParam+"&"
            }
        }
        return urlParam
    }
    
}