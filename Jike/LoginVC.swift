//
//  LoginVC.swift
//  Gather4
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class UserLoginVC:JiBaseVC {
    
    var logoV:UIImageView!
    var phoneInputV:UserCommonInputView!
    var passwordInputV:UserCommonInputView!
    
    var loginBtn:CommonButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoV = UIImageView(frame: CGRectMake(100, UISettings.common_title_height, UiUtils.getBaseWidth()/3, UiUtils.getBaseWidth()/3))
        logoV.image = UIImage(named: "test")
        logoV.center.x = self.view.frame.width/2
        
        phoneInputV = UserCommonInputView(x: 0, y: logoV.frame.maxY+UISettings.common_padding*4, width: UiUtils.getBaseWidth(),
                                          placeholder:"手机号", keyboardType:UIKeyboardType.PhonePad)
        
        passwordInputV = UserCommonInputView(x: 0, y: phoneInputV.frame.maxY+UISettings.common_padding, width: UiUtils.getBaseWidth(),
                                             placeholder:"密码", keyboardType:UIKeyboardType.EmailAddress)
        passwordInputV.setSecureText(true)
        
        loginBtn = CommonButton(x: 0, y: passwordInputV.frame.maxY+UISettings.common_padding, width: UiUtils.getBaseWidth(), title: "登录")
        loginBtn.addTarget(self, action: "loginClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let forgetPwdView = CommonClickableText(x: 0, y: UiUtils.getBaseHeight()-100, title: "忘记密码？")
        forgetPwdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "forgetPwdClicked"))
        
        let registerNewView = CommonClickableText(maxX: UiUtils.getBaseWidth(), y: UiUtils.getBaseHeight()-100, title: "注册新用户")
        registerNewView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "registerNewClicked"))
        
        self.view.addSubview(self.logoV)
        self.view.addSubview(phoneInputV)
        self.view.addSubview(passwordInputV)
        self.view.addSubview(loginBtn)
        
        self.view.addSubview(forgetPwdView)
        self.view.addSubview(registerNewView)
    
    }
    
    func loginClicked() {
        
        let phoneS = phoneInputV.getInputValue()
        let passwordS = passwordInputV.getInputValue()
        
        if(!DataUtils.isStringNotEmpty(phoneS)) {
            ToastUtils.show("请输入手机号")
        }
        else if(!DataUtils.isStringNotEmpty(passwordS)) {
            ToastUtils.show("请输入密码")
        }
        else {
            UserSystemController().login(phoneS!, password: passwordS!) { (data) -> Void in
                
                if(data?.code == 0) {
                    
                }
                else {
                    ToastUtils.show(data?.message)
                }
            }
        }
        

    }
    
    func forgetPwdClicked() {
        UiUtils.openOneNewVC(ForgetPasswordVC())
    }
    
    func registerNewClicked() {
        UiUtils.openOneNewVC(RegisterStepOneVC())
    }
    
}