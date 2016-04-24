//
//  ShareHelper.swift
//  Gather4
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


struct ShareHelper {
    
    
    static func initShareSDK() -> Void {
        /**
        *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
        *  在将生成的AppKey传入到此方法中。
        *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
        *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
        *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
        */
        
        ShareSDK.registerApp("iosv1101",
            
            activePlatforms: [SSDKPlatformType.TypeSinaWeibo.rawValue,
                SSDKPlatformType.TypeTencentWeibo.rawValue,
                SSDKPlatformType.TypeFacebook.rawValue,
                SSDKPlatformType.TypeWechat.rawValue,],
            onImport: {(platform : SSDKPlatformType) -> Void in
                
                switch platform{
                    
                case SSDKPlatformType.TypeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    
                case SSDKPlatformType.TypeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
            },
            onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                switch platform {
                    
                case SSDKPlatformType.TypeSinaWeibo:
                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                    appInfo.SSDKSetupSinaWeiboByAppKey("2247106580",
                        appSecret : "a1d70870e62c56c698e900b7174e49e0",
                        redirectUri : "http://www.sharesdk.cn",
                        authType : SSDKAuthTypeBoth)
                    break
                    
                case SSDKPlatformType.TypeWechat:
                    //设置微信应用信息
                    appInfo.SSDKSetupWeChatByAppId("wxdaf869f9bd24b02f", appSecret: "09e00845d4575e4515a5c72d4a8781e5")
                    break
                    
                case SSDKPlatformType.SubTypeQQFriend:
                    //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                    appInfo.SSDKSetupTencentWeiboByAppKey("1103292660",
                        appSecret : "M7C82lkWpe9IC6Zi",
                        redirectUri : "http://www.sharesdk.cn")
                    break

                default:
                    break
                    
                }
        })
    }
    
    
    static func shareCotent() {
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        
        shareParames.SSDKSetupShareParamsByText("分享内容",
            images : UIImage(named: "shareImg.png"),
            url : NSURL(string:"http://mob.com"),
            title : "分享标题",
            type : SSDKContentType.Text)
        
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.TypeSinaWeibo, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
            
            switch state{
                
            case SSDKResponseState.Success:
                let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: nil, cancelButtonTitle: "取消")
                alert.show()
                break

            case SSDKResponseState.Fail:    //println("分享失败,错误描述:\(error)")
                
                break
            case SSDKResponseState.Cancel:  //println("分享取消")
                
                break
                
            default:
                break
            }
        }
    }
    
    
    
    

}