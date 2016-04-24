//
//  InputPhoneGetVerifyCodeView.swift
//  Gather4
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol InputPhoneGetVerifyCodeViewDelegate {
    func sendSmsBtnClicked()
}


class InputPhoneGetVerifyCodeView:UIView {
    
    private var inputV:UITextField!
    private var sendSmsBtn:UIButton!
    private var myDelegate:InputPhoneGetVerifyCodeViewDelegate!
    
    private var countSecondValue:Int = 59
    private var conntTimer:NSTimer?
    
    
    init(x:CGFloat, y:CGFloat, width:CGFloat, delegate:InputPhoneGetVerifyCodeViewDelegate) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_input_view_height))
        
        self.backgroundColor = Color.white
        
        self.myDelegate = delegate
        inputV = UITextField(frame: CGRectMake(UISettings.common_padding, 0, width/3*2, UISettings.common_input_view_height))
        sendSmsBtn = UIButton(frame: CGRectMake(inputV.frame.maxX, 0, width/3, UISettings.common_input_view_height))
        
        inputV.placeholder = "手机号"
        inputV.keyboardType = UIKeyboardType.PhonePad
        
        sendSmsBtn.addTarget(self, action: "sendSmsClicked", forControlEvents: UIControlEvents.TouchUpInside)
        sendSmsBtn.setTitle("获取验证码", forState: UIControlState.Normal)
        sendSmsBtn.titleLabel?.font = UISettings.getFont(UISettings.common_font_size_middle)
        sendSmsBtn.backgroundColor = Color.red
        
        self.addSubview(inputV)
        self.addSubview(sendSmsBtn)
    }
    
    func getMobile() -> String? {
        return inputV.text
    }
    
    private func countSecond() {
        if(countSecondValue > 0) {
            sendSmsBtn.setTitle("\(countSecondValue)秒后重新获取", forState: UIControlState.Disabled)
            countSecondValue--
        }
        else {
            conntTimer?.invalidate()
            countSecondValue = 59
            sendSmsBtn.enabled = true
        }
    }
    
    func sendSmsClicked() {
        sendSmsBtn.setTitle("60秒后重新获取", forState: UIControlState.Disabled)
        sendSmsBtn.enabled = false
        conntTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countSecond", userInfo: nil, repeats: true)
        
        self.myDelegate.sendSmsBtnClicked()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}