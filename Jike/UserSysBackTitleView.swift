//
//  UserSysBackTitleView.swift
//  Gather4
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class UserSysBackTitleView: BaseTitleView {
    
    
    
    override init(vc:UIViewController) {
        super.init(vc:vc)
        
        let arrowImg = UIImage(named: "common_arrow_left_back_img")
        self.leftBtn.setImage(arrowImg, forState: UIControlState.Normal)
        self.leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:UISettings.common_table_padding)

        self.leftBtn.hidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}