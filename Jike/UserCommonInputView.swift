//
//  UserCommonInputView.swift
//  Gather4
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class UserCommonInputView:UIView {
    
    var inputV:UITextField!
    
    
    init(x:CGFloat, y:CGFloat, width:CGFloat, placeholder:String?, keyboardType:UIKeyboardType) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_input_view_height))
        
        inputV = UITextField(frame: CGRectMake(UISettings.common_padding, 0, width, UISettings.common_input_view_height))
        self.addSubview(inputV)
        
        self.backgroundColor = Color.white
        inputV.keyboardType = keyboardType
        inputV.placeholder = placeholder
        inputV.clearButtonMode = UITextFieldViewMode.Always
        inputV.contentVerticalAlignment = UIControlContentVerticalAlignment.Center

    }
    
    func getInputValue() -> String? {
        return inputV.text
    }
    
    func setSecureText(isSecret:Bool) {
        inputV.secureTextEntry = isSecret
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}