//
//  HttpReq.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

class HttpReq: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    var manager:AFHTTPRequestOperationManager!
    var responseData: NSMutableData = NSMutableData()
    
    override init() {
        super.init()
        initAFManager()
    }

    private func initAFManager() {
        self.manager = AFHTTPRequestOperationManager()

        var set = NSSet(object: "text/plain") as Set<NSObject>
        set.insert("application/json")
        self.manager.responseSerializer.acceptableContentTypes = set
        self.manager.requestSerializer.timeoutInterval = 18
        self.manager.requestSerializer.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
    }
    
    func request(serverUrl:String, urlPath:String, params:HttpParams, back:(AnyObject)->Void) {

        let urlString = serverUrl+urlPath+(params.getParamString())
        LogUtils.log("request():urlString=\(urlString)")
        
        let strUrl = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())

        self.manager.POST(strUrl!, parameters: nil, success: { (operation, responseObject) -> Void in

            if(NSJSONSerialization.isValidJSONObject(responseObject)) {

                let respString = DataUtils.getJsonStringByDic(responseObject as? NSDictionary)

                if(Constants.is_show_log) {
                    LogUtils.log("AFsuc=\(respString)")
                }

                back(respString)
            }
            else {
                if(Constants.is_show_log) {
                    LogUtils.log("AFnotJson=\(responseObject)")
                }
                self.returnError(back)
            }

        }) { (operation, error) -> Void in

            if(Constants.is_show_log) {
                LogUtils.log("AFerror=\(error)")
            }
            self.returnError(back)
        }
    }

    private func returnError(back:(AnyObject)->Void) {
        
        let backDic:NSMutableDictionary = NSMutableDictionary()
        backDic.setValue(-1, forKey: "code")
        backDic.setValue("网络暂时不通畅，请稍后再试", forKey: "message")

        back(DataUtils.getJsonStringByDic(backDic as NSDictionary))
    }

}