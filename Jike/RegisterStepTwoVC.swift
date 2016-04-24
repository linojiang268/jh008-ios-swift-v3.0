//
//  RegisterStepTwoVC.swift
//  Gather4
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class RegisterStepTwoVC: JiBaseVC, UserSelectViewDelegate, PickerDelegate, GetAndInputVerifyCodeViewDelegate {
    
    private var headIconView:UserHeadIcon!
    private var nicknameView:UserInputWithTitleView!
    private var genderSelectV:UserSelectView!
    private var birthDaySelectV:UserSelectView!
    
    private var phoneView:UserInputWithTitleView!
    private var passwordView:PasswordInputWithTitleView!
    private var verifyCodeView:GetAndInputVerifyCodeView!
    
    private var regBtn:CommonButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBgImg()
        
        let titleV = UserSysBackTitleView(vc: self)
        titleV.setTitle("注册")
        
        headIconView = UserHeadIcon(frame: CGRectMake(0, titleV.frame.maxY+UISettings.common_padding*2, baseWidth/3, baseWidth/3), vc:self)
        headIconView.center.x = baseWidth/2
        
        nicknameView = UserInputWithTitleView(x: 0, y: headIconView.frame.maxY+UISettings.common_padding*2, width: baseWidth,
                                              title: "昵称", keyboardType: UIKeyboardType.EmailAddress)
        
        genderSelectV = UserSelectView(viewKey:"gender", x: 0, y: nicknameView.frame.maxY+UISettings.common_padding, width: baseWidth, title: "性别",
                                       defaultValue: DataSelectedItem(id: DataSettings.getGenderCodeByEnum(DataSettings.Gender.Male), value: "男"),
                                       delegate: self)
        
        birthDaySelectV = UserSelectView(viewKey: "birthday", x: 0, y: genderSelectV.frame.maxY, width: baseWidth, title: "生日",
                                         defaultValue: DataSelectedItem(id: 1, value: "1990-10-11"), delegate: self)
        
        phoneView = UserInputWithTitleView(x: 0, y: birthDaySelectV.frame.maxY+UISettings.common_padding*2, width: baseWidth, title: "电话",
                                           keyboardType: UIKeyboardType.PhonePad)
        
        passwordView = PasswordInputWithTitleView(x: 0, y: phoneView.frame.maxY, width: baseWidth, title: "密码")
        
        verifyCodeView = GetAndInputVerifyCodeView(x: 0, y: passwordView.frame.maxY, width: baseWidth, delegate: self)
        
        regBtn = CommonButton(x: 0, y: verifyCodeView.frame.maxY+UISettings.common_padding*2, width: baseWidth, title: "注册")
        regBtn.addTarget(self, action: "registerBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(titleV)
        self.view.addSubview(headIconView)
        self.view.addSubview(nicknameView)
        self.view.addSubview(genderSelectV)
        self.view.addSubview(birthDaySelectV)
        self.view.addSubview(phoneView)
        self.view.addSubview(passwordView)
        self.view.addSubview(verifyCodeView)
        self.view.addSubview(regBtn)
    }
    
    func selectClicked(viewKey:String, defaultData:DataSelectedItem?) {
        if(viewKey == "gender") {
            let picker = PickerGender(pickerKey:"pickGender", parentView: self.view, pickerDel: self,
                                      selectedData: DataSelectedItem(id: DataSettings.getGenderCodeByEnum(DataSettings.Gender.Male), value: "男"))
            picker.showPicker()
        }
        else if(viewKey == "birthday") {
            let birthPicker = PickerBirthday(pickerKey: "pickBirthday", parentView: self.view, pickerDel: self, selectedData: nil)
            birthPicker.showPicker()
        }
    }
    
    func pickerSelected(pickerKey:String, selectedData:DataSelectedItem?) {
        if(pickerKey == "pickGender") {
            genderSelectV.resetSelectedValue(selectedData)
        }
        else if(pickerKey == "pickBirthday") {
            
        }
    }
    
    func getVerifyCodeBtnClicked() {
        
    }
    
    func registerBtnClicked() {
        
    }
    
}
