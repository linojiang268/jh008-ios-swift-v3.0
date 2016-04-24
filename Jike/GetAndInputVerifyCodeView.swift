//
//  GetAndInputVerifyCodeView.swift
//  Gather4
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol GetAndInputVerifyCodeViewDelegate {
    func getVerifyCodeBtnClicked()
}

class GetAndInputVerifyCodeView: UIView {
    
    
    private var inputV:UITextField!
    private var getVerifyCodeBtn:UIButton!
    private var myDelegate:GetAndInputVerifyCodeViewDelegate!
    
    private var countSecondValue:Int = 59
    private var conntTimer:NSTimer?
    
    
    init(x:CGFloat, y:CGFloat, width:CGFloat, delegate:GetAndInputVerifyCodeViewDelegate) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_input_view_height))
        
        self.backgroundColor = Color.white
        
        self.myDelegate = delegate
        inputV = UITextField(frame: CGRectMake(UISettings.common_padding, 0, width/3*2, UISettings.common_input_view_height))
        getVerifyCodeBtn = UIButton(frame: CGRectMake(inputV.frame.maxX, 0, width/3, UISettings.common_input_view_height))
        
        inputV.placeholder = "验证码"
        inputV.keyboardType = UIKeyboardType.EmailAddress
        
        getVerifyCodeBtn.addTarget(self, action: "getVerifyCodeClicked", forControlEvents: UIControlEvents.TouchUpInside)
        getVerifyCodeBtn.setTitle("获取验证码", forState: UIControlState.Normal)
        getVerifyCodeBtn.titleLabel?.font = UISettings.getFont(UISettings.common_font_size_middle)
        getVerifyCodeBtn.backgroundColor = Color.red
        
        self.addSubview(inputV)
        self.addSubview(getVerifyCodeBtn)
    }
    
    func countSecond() {
        if(countSecondValue > 0) {
            getVerifyCodeBtn.setTitle("\(countSecondValue)秒后重新获取", forState: UIControlState.Disabled)
            countSecondValue--
        }
        else {
            conntTimer?.invalidate()
            countSecondValue = 59
            getVerifyCodeBtn.enabled = true
        }
    }
    
    func getVerifyCodeClicked() {
        getVerifyCodeBtn.setTitle("60秒后重新获取", forState: UIControlState.Disabled)
        getVerifyCodeBtn.enabled = false
        conntTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countSecond", userInfo: nil, repeats: true)
        
        self.myDelegate.getVerifyCodeBtnClicked()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}