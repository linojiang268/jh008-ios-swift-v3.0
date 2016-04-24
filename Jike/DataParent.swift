//
//  DataParent.swift
//  Jike
//
//  Created by Iosmac on 15/6/3.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

class DataParent: NSObject {

    var code:Int?
    var message:String?
    
    override init() {
        super.init()
    }
    
    init?(_ map: Map) {
        super.init()
        code     <- map["code"]
        message     <- map["message"]
    }

    func isSuc() -> Bool {
        return code == 0
    }

}