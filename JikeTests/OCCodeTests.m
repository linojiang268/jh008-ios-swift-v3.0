//
//  OCCodeTests.m
//  Jike
//
//  Created by jsonmess on 15/9/16.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DMDeviceManager.h"
@interface OCCodeTests : XCTestCase

@end

@implementation OCCodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testTranformVersion
{
    NSInteger value = [DMDeviceManager transformVersionStringToInt:@"1.2.3.4"];
    XCTAssert(value > 0,@"转换出现错误，失败了");
}
@end
