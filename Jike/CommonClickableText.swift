//
//  CommonClickableText.swift
//  Gather4
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class CommonClickableText:UILabel {
    
    
    init(x:CGFloat, y:CGFloat, title:String) {
        super.init(frame: CGRectMake(x, y, 0, UISettings.common_select_view_height))
        
        initSelf(title)
        UiUtils.resetViewWidthByChar(self, text: self.text, viewHeight: self.frame.height, fontSize: self.font.pointSize)
    }
    
    init(maxX:CGFloat, y:CGFloat, title:String) {
        super.init(frame: CGRectMake(maxX, y, 0, UISettings.common_select_view_height))
        
        initSelf(title)
        UiUtils.resetViewWidthByChar(self, text: self.text, viewHeight: self.frame.height, fontSize: self.font.pointSize)
        self.frame.origin.x = maxX - self.frame.width
    }
    
    init(x: CGFloat, y:CGFloat, width:CGFloat, title:String) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_select_view_height))
        
        initSelf(title)
        UiUtils.resetViewHeightByChar(self, text: self.text, viewWidth: self.frame.width, fontSize: self.font.pointSize)
    }
    
    private func initSelf(title:String) {
        self.userInteractionEnabled = true
        self.text = title
        
        self.font = UISettings.getFont(UISettings.common_font_size_middle)
        self.textColor = Color.common_text_color_black
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}