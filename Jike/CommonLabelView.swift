//
//  CommonLabelView.swift
//  Gather4
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class CommonLabelView: UILabel {
    
    init(x:CGFloat, y:CGFloat, text:String?) {
        super.init(frame: CGRectMake(x, y, 0, UISettings.common_label_view_height))
        
        initView(text)
        UiUtils.resetViewWidthByChar(self, text: text, viewHeight: self.frame.height, fontSize: self.font.pointSize)
    }
    
    init(x:CGFloat, y:CGFloat, width:CGFloat, text:String?) {
        super.init(frame: CGRectMake(x, y, width, 0))
        
        initView(text)
        UiUtils.resetViewHeightByChar(self, text: text, viewWidth: width, fontSize: self.font.pointSize)
    }
    
    init(x:CGFloat, y:CGFloat, maxWidth:CGFloat, text:String?) {
        super.init(frame: CGRectMake(x, y, 0, UISettings.common_label_view_height))
        
        initView(text)
        UiUtils.resetViewWidthByChar(self, text: text, viewHeight: self.frame.height, fontSize: self.font.pointSize)
        if(maxWidth < self.frame.width) {
            UiUtils.resetViewHeightByChar(self, text: text, viewWidth: maxWidth, fontSize: self.font.pointSize)
        }
    }
    
    private func initView(text:String?) {
        self.text = text
        self.font = UISettings.getFont(UISettings.common_font_size_middle)
        self.textColor = Color.common_text_color_black
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}