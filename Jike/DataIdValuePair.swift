//
//  DataIdValuePair.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation


class DataIdValuePair {

    var id:Int?
    var key:String?
    var value:String?

    var otherId:Int?
    var otherKey:String?
    var otherValue:String?
    
    init() {
        
    }
    
    init(id:Int?, value:String?) {
        
        self.id = id
        self.value = value
    }
    
    init(key:String?, value:String?) {
        
        self.key = key
        self.value = value
    }
}