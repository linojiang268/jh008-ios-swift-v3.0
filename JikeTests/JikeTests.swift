//
//  JikeTests.swift
//  JikeTests
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import XCTest

class JikeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    //测试男女开关
//    func testUserPictures()
//    {
//    //1.男女都开
//        NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "settingRecommend")
//        //设置男开
//     var testValue = JKSettingRecommendTool.updateRecommendStatus(nil, wuman: false)
//        XCTAssert(testValue.0 && !testValue.1, "关闭女生返回错误")
//       NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "settingRecommend")
//         testValue = JKSettingRecommendTool.updateRecommendStatus(false, wuman: nil)
//        XCTAssert(!testValue.0 && testValue.1, "关闭男生返回错误")
//        //默认女生关
//        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "settingRecommend")
//         testValue = JKSettingRecommendTool.updateRecommendStatus(nil, wuman: true)
//        XCTAssert(testValue.0 && testValue.1, "开启男生生返回错误")
//        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "settingRecommend")
//        testValue = JKSettingRecommendTool.updateRecommendStatus(false, wuman: nil)
//        XCTAssert(!testValue.0 && testValue.1, "关闭男生返回错误")
//        NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "settingRecommend")
//        testValue = JKSettingRecommendTool.updateRecommendStatus(nil, wuman: false)
//        XCTAssert(testValue.0 && !testValue.1, "关闭女生返回错误")
//        
//    }
    
    //测试获取banner数据
    func testGetBannerData()
    {
    
    }
}
