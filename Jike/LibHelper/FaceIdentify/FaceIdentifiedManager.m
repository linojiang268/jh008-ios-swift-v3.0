//
//  FaceIdentifiedManager.m
//  Jike
//
//  Created by jsonmess on 15/8/10.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import "FaceIdentifiedManager.h"

@implementation FaceIdentifiedManager

+(void)indentifiedFaceFromImage:(UIImage *)image successBlock:(faceIdentifiedSuccess)block
{
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    if (image != nil)
    {
        CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
        //配置人脸识别（精准度：高）
        NSDictionary  *detectorConfig = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                                    forKey:CIDetectorAccuracy];
        //初始化检测器
        CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:nil
                                                  options:detectorConfig];
        NSArray* features = [detector featuresInImage:ciimage];
        block(features);
    }
   // });
}

+(NSArray *)indentifiedFaceFromImage:(UIImage *)image
{
    CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
    //配置人脸识别（精准度：高）
    NSDictionary  *detectorConfig = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                                forKey:CIDetectorAccuracy];
    //初始化检测器
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:detectorConfig];
    NSArray* features = [detector featuresInImage:ciimage];
    
    return features;
}
@end
