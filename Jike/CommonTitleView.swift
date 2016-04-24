//
//  CommonTitleView.swift
//  Jike
//
//  Created by Iosmac on 15/5/14.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit



class CommonTitleView: BaseTitleView {
    
    
    
    override init(vc:UIViewController) {
        super.init(vc:vc)
        
        let arrowImg = UIImage(named: "common_arrow_left_back_img")
        self.leftBtn.setImage(arrowImg, forState: UIControlState.Normal)
        self.leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:UISettings.common_table_padding)
        self.leftBtn.hidden = true
        self.leftBtn.addTarget(self, action: "clickBtnLeftBack", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.rightBtn.setTitle("完成", forState: UIControlState.Normal)
        
        self.leftBtn.hidden = false
        self.rightBtn.hidden = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}