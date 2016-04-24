//
//  PasswordInputView.swift
//  Gather4
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class PasswordInputView: UserCommonInputView {
    
    var toggleOpenPassword:UIButton!
    
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, placeholder: String?) {
        super.init(x: x, y: y, width: width, placeholder: placeholder, keyboardType: UIKeyboardType.EmailAddress)
        
        toggleOpenPassword = UIButton(frame: CGRectMake(self.frame.width-self.frame.height, 0, self.frame.height, self.frame.height))
        toggleOpenPassword.backgroundColor = Color.red
        
        toggleOpenPassword.addTarget(self, action: "toggleOpenPasswordClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(toggleOpenPassword)
        
        setSecureText(true)
    }
    
    func toggleOpenPasswordClicked() {
        setSecureText(!inputV.secureTextEntry)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}