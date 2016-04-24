//
//  PasswordInputWithTitleView.swift
//  Gather4
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class PasswordInputWithTitleView: UIView {
    
    private var inputV:PasswordInputView!
    private var titleV:CommonLabelView!
    
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, title:String?) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_input_view_height))
        
        titleV = CommonLabelView(x: UISettings.common_padding, y: 0, text: title)
        inputV = PasswordInputView(x: width/4, y: y, width: width/4*3, placeholder: nil)

        self.addSubview(titleV)
        self.addSubview(inputV)
        
        titleV.text = title
        titleV.textColor = Color.common_text_color_gray
        
        self.backgroundColor = Color.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}