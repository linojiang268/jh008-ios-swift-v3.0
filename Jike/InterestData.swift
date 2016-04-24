//
//  InterestData.swift
//  Gather4
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class InterestData : DataParent {
    
    var isSelected:Bool = false
    var interestName:String?
    var imgNameNormal:String?
    var imgNameSelected:String?
    var bgColor:UIColor?
    

    init(interestName:String?, imgNameNormal:String?, imgNameSelected:String?, bgColor:UIColor?) {
        super.init()
        
        self.interestName = interestName
        self.imgNameNormal = imgNameNormal
        self.imgNameSelected = imgNameSelected
        self.bgColor = bgColor
    }
    
    
}
