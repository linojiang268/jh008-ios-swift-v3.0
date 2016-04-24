//
//  FaceIdentifiedManager.h
//  Jike
//
//  Created by jsonmess on 15/8/10.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
//识别结束
typedef void (^faceIdentifiedSuccess)(NSArray *faceArray);
@interface FaceIdentifiedManager : NSObject
/**
 *  从图片中获取识别的人脸数量
 *
 *  @param image 带有人脸的图片
 *
 *  @param block 识别成功后回调
 */
+(void)indentifiedFaceFromImage:(UIImage*)image successBlock:(faceIdentifiedSuccess)block;


+(NSArray*)indentifiedFaceFromImage:(UIImage*)image;
@end
