//
//  GatherParams.swift
//  Gather4
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation

class GatherParams: HttpParams {
    
    override init() {
        super.init()
        
        addCommonParams()
    }
    
    func addCommonParams() {
        addParam("version", value: HttpUtils.getAppVersion())
    }
}