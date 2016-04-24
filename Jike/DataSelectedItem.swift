//
//  DataSelectedItem.swift
//  Gather4
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class DataSelectedItem:NSObject {
    
    
    var id:Int?
    var key:String?
    var value:String?
    
    
    init(id:Int?, value:String?) {
        self.id = id
        self.value = value
    }
}