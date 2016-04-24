//
//  ForgetPasswordVC.swift
//  Gather4
//
//  Created by apple on 15/11/2.
//

import Foundation


class ForgetPasswordVC:JiBaseVC, InputPhoneGetVerifyCodeViewDelegate {
    
    var inputPhoneV:InputPhoneGetVerifyCodeView!
    var tipsV:UILabel!
    var verifyCodeV:UserCommonInputView!
    var passwordV:PasswordInputView!
    
    var resetBtn:CommonButton!
    
    var control:UserSystemController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleV = UserSysBackTitleView(vc: self)
        titleV.setTitle("忘记密码")
        
        setBgImg()
        
        tipsV = UiUtils.createCommonLabel(0, y: titleV.frame.maxY+UISettings.common_padding*4, width: UiUtils.getBaseWidth(),
                                          fontSize: UISettings.common_font_size_middle, title: "您可以重新设置您的密码")
        
        inputPhoneV = InputPhoneGetVerifyCodeView(x: 0, y: tipsV.frame.maxY+UISettings.common_padding*2, width: UiUtils.getBaseWidth(), delegate: self)
        
        verifyCodeV = UserCommonInputView(x: 0, y: inputPhoneV.frame.maxY+UISettings.common_padding, width: UiUtils.getBaseWidth(),
                                          placeholder: "验证码", keyboardType: UIKeyboardType.EmailAddress)
        
        passwordV = PasswordInputView(x: 0, y: verifyCodeV.frame.maxY+UISettings.common_padding, width: UiUtils.getBaseWidth(), placeholder: "新密码")
        
        resetBtn = CommonButton(x: 0, y: passwordV.frame.maxY+UISettings.common_padding*4, width: UiUtils.getBaseWidth(), title: "重新设置")
        resetBtn.addTarget(self, action: "resetBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(titleV)
        self.view.addSubview(tipsV)
        self.view.addSubview(inputPhoneV)
        self.view.addSubview(verifyCodeV)
        self.view.addSubview(passwordV)
        self.view.addSubview(resetBtn)
        
        control = UserSystemController()
    }
    
    
    func sendSmsBtnClicked() {
        if(DataUtils.isStringNotEmpty(inputPhoneV.getMobile())) {
            control.getVerifyCodeWhenResetPassword(inputPhoneV.getMobile()!, back: { (data) -> Void in
                
                if(data?.isSuc() == true) {
                    
                }
                else {
                    ToastUtils.show(data?.message)
                }
            })
        }
    }
    
    func resetBtnClicked() {
        
    }
}