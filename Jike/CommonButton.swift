//
//  CommonButton.swift
//  Gather4
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class CommonButton:UIButton {
    
    
    init(x: CGFloat, y:CGFloat, width:CGFloat, title:String?) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_button_view_height))
        
        self.setTitleColor(Color.white, forState: UIControlState.Normal)
        self.titleLabel?.font = UISettings.getFont(UISettings.common_font_size_middle)
        
        self.backgroundColor = Color.styleColor
        
        self.setTitle(title, forState: UIControlState.Normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}