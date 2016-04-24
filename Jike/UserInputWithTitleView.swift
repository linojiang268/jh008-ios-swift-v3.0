//
//  UserInputWithTitleView.swift
//  Gather4
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class UserInputWithTitleView: UIView {
    
    private var titleV:CommonLabelView!
    private var inputV:UITextField!
    
    init(x: CGFloat, y:CGFloat, width:CGFloat, title:String?, keyboardType:UIKeyboardType) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_input_view_height))
        
        titleV = CommonLabelView(x: UISettings.common_padding, y: 0, text: title)
        inputV = UITextField(frame: CGRectMake(width/4, 0, width/4*3, UISettings.common_input_view_height))
        
        titleV.textColor = Color.common_text_color_gray
        
        titleV.text = title
        inputV.keyboardType = keyboardType
        
        self.addSubview(titleV)
        self.addSubview(inputV)
        
        self.backgroundColor = Color.white
    }
    
    func getInputedValue() -> String? {
        return self.inputV.text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}