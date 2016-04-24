//
//  DataUtils.swift
//  Jike
//
//  Created by ios on 15-4-21.
//

import Foundation
import UIKit

struct DataUtils {

    
    
    
    static func replaceEnterToBlankInString(inputString:String?) -> String? {//将回车符换成空格,用于晒图界面分享的那句话，防止换行过多
        if(inputString != nil) {
            return inputString?.stringByReplacingOccurrencesOfString("\n", withString: " ",
                                options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        return nil
    }

    static func detectHunManFace(imgUrl:String?) {//检测人脸,并将检测结果持久化到本地

        var isHumanF = false

        if(isStringNotEmpty(imgUrl)) {

            let url  = NSURL(string: imgUrl!)

            if(url != nil) {
                let data = NSData(contentsOfURL:url!)
                if(data != nil) {
                    let img = UIImage(data: data!)
                    if(img != nil) {
                        FaceIdentifiedManager.indentifiedFaceFromImage(img,
                        successBlock: { (array) -> Void in

                            isHumanF = (array != nil && array?.count > 0) ? true : false
                        })
                    }
                }
            }
        }

        let anyobjec = NSNumber(bool:isHumanF)
        NSUserDefaults.standardUserDefaults().setObject(anyobjec, forKey: "userDidUploadFaceAvatar")
    }

    static func containsString(originS:String?, containsS:String?) -> Bool {
        if(originS != nil && containsS != nil) {
            let range = originS!.rangeOfString(containsS!)
            return range?.startIndex != nil
        }
        return false
    }

    //字符串判空的函数
    static func isStringNotEmpty(s:String?) -> Bool {
        return s != nil && (s!).characters.count>0
    }


    static func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        LogUtils.log("RBResizeImage(): width=\(targetSize.width), height=\(targetSize.height)")

        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    static func getDataArrayForNTY(urlArr:[String]) -> [AnyObject] {//不再用sdweb manager下载了，改用在NTY回调中用sd挨个下载

        var objArr = [AnyObject]()
        let cache = SDImageCache.sharedImageCache()

        for (var i = 0; i<urlArr.count; i++) {
            let url = urlArr[i] as String
            var urlStr:NSString = NSString(string: url)
            urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            if(NSURL(string: urlStr as String) != nil) {

                let chacedImg = cache.imageFromDiskCacheForKey(urlStr as String)

                if(chacedImg != nil) {
                    let itemP = DataMyNTYPhoto(image:chacedImg,
                                               attributedCaptionTitle:UiUtils.getParagraphAttributeString(""))
                    itemP.index = i
                    objArr.append(itemP)
                }
                else {
                    //let imgNet = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
                    
                    let itemP = DataMyNTYPhoto(image:nil,
                                               attributedCaptionTitle:UiUtils.getParagraphAttributeString(""))
                    itemP.index = i
                    objArr.append(itemP)
                }
            }
        }

        return objArr
    }

    static func isValidEmail(email:String) -> Bool {
//        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluateWithObject(email)

        return (email.characters.count>0 && email.rangeOfString("@") != nil && email.rangeOfString(".") != nil)
    }

    static func isValidPassword(password:String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{6,30}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluateWithObject(password)
    }

    static func getEncryptPassword(pwd: String) -> String {
        let sha2 = "pwd.sha256()"
        let realIndex = sha2.endIndex.advancedBy(-10)
        let reverseS = String(Array(pwd.characters.reverse()))
        let encrepPwd = "\(sha2.substringFromIndex(realIndex).lowercaseString)\(reverseS)"
        return encrepPwd
    }

    static func getDeviceId() -> String {
        let uniqueId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        return uniqueId
    }

    //将字符串UTF8编码
    static func getUTF8String(input:String) -> String {//转utf-8
        var urlStr:NSString = NSString(string: input)
        urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        return urlStr as String
    }

    /**
    * DEK Knuth的hash算法
    * @param content内容
    * @return
    */
    static func DEKHash(content:String) -> UInt64 {
        var hash = UInt64(content.characters.count)
        let charArr = Array(content.characters)
        for char in charArr {
            var res = stringToByteArray(String(char))
            hash = ((hash << 5) ^ (hash >> 27)) ^ UInt64(res[0])
        }
        LogUtils.log("DEKHash(): content=\(content), hash=\(hash)")
        return hash
    }

    static func getStringFromLoc(key:String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    //字符串转换为字节数组
    static func stringToByteArray(emailPwdString:String) -> [UInt8] {
        let buf = [UInt8](emailPwdString.utf8)
        //LogUtils.log("buf=\(buf)")
        return buf
    }

    static func base64Encode(s:String) -> String {
        let plainData = (s as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        let base64String = plainData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        LogUtils.log("base64Encode():input=\(s)")
        LogUtils.log("base64Encode():output=\(base64String)")
        return base64String
    }

    static func base64Decode(base64String:String) -> String {
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))!
        let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding)!
        LogUtils.log("base64Decode():input=\(base64String)")
        LogUtils.log("base64Decode():output=\(decodedString)")
        return decodedString as String
    }

    //为上传七牛的图片文件生成一个时间相关的文件名
    static func getDataTimeStringForFileName() -> String {

        let timeZone = NSTimeZone(name: "Asia/Shanghai")

        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        if(timeZone != nil) {
            formatter.timeZone = timeZone
        }
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let resDataString = formatter.stringFromDate(NSDate())

        let formNum = NSNumberFormatter()

        let isNum = formNum.numberFromString(resDataString)?.longLongValue

        if(Constants.is_show_log) {
            LogUtils.log("getDataTimeStringForFileName=\(resDataString),isNum=\(isNum)")
        }

        if(isNum != nil && isNum > 0) {
            return resDataString
        }

        return String(Int64(NSDate().timeIntervalSince1970*1000*1000))
    }

    //格式化facebook的时间字符串
    static func formatFacebookDatetime(dateString:String?) -> String {

        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        let timeZone = NSTimeZone(name: "Asia/Shanghai")
        if(timeZone != nil) {
            formatter.timeZone = timeZone
        }

        if(dateString != nil) {
            let date = formatter.dateFromString(dateString!)

            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.stringFromDate(date != nil ? date! : NSDate())
        }
        else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.stringFromDate(NSDate())
        }
    }

    //获取当前系统设置的时区的int字符串
    static func getTimeZoneInNum() -> String {
        let secondsFromGMT = NSTimeZone.systemTimeZone().secondsFromGMT
        let timeZone = Int(secondsFromGMT/60/60)
        LogUtils.log("getTimeZoneInNum():secondsFromGMT=\(secondsFromGMT), timeZone=\(timeZone)")
        return "\(timeZone)"
    }

    //将字典转换为json字符串
    static func getJsonStringByDic(dic:NSDictionary?) -> String {
        if(dic != nil) {
            var jsonData:NSData?
            do
            {
              try  jsonData = NSJSONSerialization.dataWithJSONObject(dic!, options: NSJSONWritingOptions())
                return NSString(data: jsonData!, encoding: NSUTF8StringEncoding)! as String
            }
            catch
            {
               return "{}"
            }
        }
        else
        {
            return "{}"
        }
    }

    //将数组转换为josn字符串
    static func getJsonStringByDic(dic:NSArray) -> String {
        let jsonData = try? NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions())
        return NSString(data: jsonData!, encoding: NSUTF8StringEncoding)! as String
    }
    
    func getLocalizedString(key:String) -> String {
        return NSLocalizedString(key, comment: "any comment")
    }
    
    static func getAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    static func getUDID() -> String {
        return UIDevice.currentDevice().identifierForVendor!.UUIDString
    }

    //获取当前时间的字符串
    static func getDateTimeString() -> String {
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US")
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"MM-dd 'at' HH:mm:ss.SSS"
        let time = timeFormatter.stringFromDate(date) as String
        LogUtils.log("getDateTime():time=\(time)")
        return time
    }

    //根据传入时间值，格式化出可读的时间字符串
    static func getDateTimeString(time:Int64) -> String {
        let date = NSDate(timeIntervalSinceReferenceDate: Double(time))
        let timeFormatter = NSDateFormatter()
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US")
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"MM-dd 'at' HH:mm:ss.SSS"
        let time = timeFormatter.stringFromDate(date) as String
        LogUtils.log("getDateTime():time=\(time)")
        return time
    }
    
    static func getDateTimeValue() -> Int64 {
        let date = NSDate()
        let long = Int64(date.timeIntervalSince1970)//秒
        //LogUtils.log("getDateTime():long=\(long)")
        return long
    }

    //生成随机数
    static func getRandom(max:Int) ->Int {
        return Int(arc4random_uniform(UInt32(max)))
    }

    //将创建的数据库都放在某个目录下，所有生成sqlite的函数最好都从此函数生成目录
    static func getSqliteFilePath(fileName:String) -> String {
        let manager = NSFileManager.defaultManager()
        let docPathArr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
                                                             NSSearchPathDomainMask.AllDomainsMask, true)
        let docDirPathUrl = NSURL(fileURLWithPath: docPathArr[0], isDirectory: true)
        let docDirPath = docDirPathUrl.URLByAppendingPathComponent("sqlite_databases/").path
        do {
            try manager.createDirectoryAtPath(docDirPath!, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError  {
            LogUtils.log("getSqliteFilePath():error\(error)")
        }
        let docFilePath = NSURL(string: docDirPath!)?.URLByAppendingPathComponent(fileName).absoluteString
        LogUtils.log("getSqliteFilePath():\(docFilePath), fileName=\(fileName)")
        return docFilePath!

    }
    
    static func getSignString(dic: NSDictionary) -> String {
        return UseSign().createSign(dic as! [NSObject : AnyObject], kSignKey: Constants.sign_key)
    }

    //将工程中得资源拷贝到沙盒目录中
    static func copyResDbToSandDoc() {

        let bun = NSBundle.mainBundle()
        let manager = NSFileManager.defaultManager()

        let list = try? manager.contentsOfDirectoryAtPath(bun.bundlePath)

        let docPathArr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)

        let docDirPath = NSURL(string: docPathArr[0])?.URLByAppendingPathComponent("dbs/").absoluteString

        LogUtils.log("copyResDbToSandDoc():docDirPath=\(docDirPath)")

        for item in list! {
            let dbDestPath = NSURL(string: docDirPath!)?.URLByAppendingPathComponent(item).absoluteString
            LogUtils.log("item=\(item)")

            if(!manager.fileExistsAtPath(dbDestPath!) && NSURL(string:item)?.pathExtension=="db") {

                do {
                    try manager.copyItemAtPath("\(bun.bundlePath)/\(item)", toPath: dbDestPath!)
                } catch _ {
                }
            }
        }
    }

}