//
//  UserSystemController.swift
//  Gather4
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class UserSystemController: BaseController {
    
    
    //登录
    func login(mobile:String, password:String, back:(LoginData?)->Void) {
        
        let param = GatherParams()
        param.addParam("mobile", value: mobile)
        param.addParam("password", value: password)
        param.addParam("sign", value: DataUtils.getSignString(param.getParamDictionary()))
        
        ReqServer().requestGatherServer("/api/login", params: param) { (data) -> Void in
            
            back(Mapper<LoginData>().map(data as! String))
        }
    }
    
    //重置密码时获取手机验证码
    func getVerifyCodeWhenResetPassword(mobile:String, back:(DataCommonRegRes?)->Void) {
        
        
        let param = GatherParams()
        param.addParam("mobile", value: mobile)
        
        ReqServer().requestGatherServer("/api/password/reset/verifycode", params: param) { (data) -> Void in
            
            let res = Mapper<DataCommonRegRes>().map(data as! String)
            back(res)
        }
    }
    
    
    
}