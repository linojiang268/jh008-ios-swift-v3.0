//
//  ReqServer.swift
//  Seed
//
//  Created by ios on 15-3-17.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

class ReqServer {
    
    func requestGatherServer(urlPath:String, params:GatherParams?, dataBack:(AnyObject)->Void) {
        
        requestServer(Constants.server_url, urlPath: urlPath, params: params, dataBack: dataBack)
    }
    
    func requestServer(serverUrl:String, urlPath:String, params:HttpParams?, dataBack:(AnyObject)->Void) {
        
        if(params == nil) {
            HttpReq().request(serverUrl, urlPath: urlPath, params: HttpParams(), back: dataBack)
        }
        else {
            HttpReq().request(serverUrl, urlPath: urlPath, params: params!, back: dataBack)
        }
    }
}