//
//  AudioHelper.swift
//  Jike
//
//  Created by Iosmac on 15/7/29.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import AVFoundation

//播放语音消息的帮助类
class AudioHelper {

    private var audioRecorder:AVAudioRecorder!
    private var recordFilePath:String!

    func record() -> Bool {

        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch _ {
            
        }
        
        do {
            try audioSession.setActive(true)
        }
        catch _ {
            
        }

        recordFilePath = getRecordFilePath("record_voice_\(DataUtils.getDataTimeStringForFileName()).caf")

        let url = NSURL.fileURLWithPath(recordFilePath as String)

        let recordSettings:[String : AnyObject] = [
            AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatAppleIMA4) ,
            AVSampleRateKey:1024 as NSNumber,
            AVNumberOfChannelsKey:2 as NSNumber,
            AVEncoderBitRateKey:3200 as NSNumber,
            AVLinearPCMBitDepthKey:16 as NSNumber,
            AVEncoderAudioQualityKey:AVAudioQuality.Medium.rawValue as NSNumber
        ]
        LogUtils.log("AudioHelper:record()=\(url)")
        do {
            audioRecorder = try AVAudioRecorder(URL: url, settings: recordSettings )
        } catch {
            audioRecorder = nil
            LogUtils.log((error as NSError).localizedDescription)
            return false
        }
            return audioRecorder.record()
    }

    func getRecordFilePath(fileName:String) -> String {
        let manager = NSFileManager.defaultManager()
        let docPathArr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory,
                                                             NSSearchPathDomainMask.UserDomainMask, true)
        let docDirPath = NSURL(string:docPathArr[0])?.URLByAppendingPathComponent("msg_recorded_voice/")
        do {
            try manager.createDirectoryAtPath(docDirPath!.absoluteString, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
        }
        let docFilePath = docDirPath?.URLByAppendingPathComponent(fileName).absoluteString
        LogUtils.log("getRecordFilePath():\(docFilePath)")
        return docFilePath!
    }

    func stopAndGetFile() -> String {
        audioRecorder.stop()
        LogUtils.log("stopAndGetFile():recordFilePath=\(recordFilePath)")
        return recordFilePath
    }

}