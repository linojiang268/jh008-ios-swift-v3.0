//
//  CleanFileCacheManager.m
//  Jike
//
//  Created by jsonmess on 15/7/24.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import "CleanFileCacheManager.h"

@implementation CleanFileCacheManager

+(void)cleanFileCacheSizeWithFinished:(cleanFileBlock)cleanBlock
{
    NSString *pathStr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSEnumerator *enumerator=[[fileManager subpathsAtPath:pathStr] objectEnumerator];
            NSString *fileName;
            while (fileName=[enumerator nextObject])
            {
                //清除图片缓存
                NSRange range = [fileName rangeOfString:@"SDWebImageCache"];
                //清除录音缓存
                 NSRange rangeAudio = [fileName rangeOfString:@"recorded_voice"];
               if (range.length > 0 )
               {
                   NSString *fileNameAbs=[pathStr stringByAppendingPathComponent:fileName];
                   [fileManager removeItemAtPath:fileNameAbs error:nil];
               }
                else if (rangeAudio.length > 0)
                {
                    NSString *fileNameAbs=[pathStr stringByAppendingPathComponent:fileName];
                    [fileManager removeItemAtPath:fileNameAbs error:nil];
                }
               else
               {
                   continue;
               }
            }
            //主线程更新UI
            dispatch_sync(dispatch_get_main_queue(), ^{
                cleanBlock();
            });
        });
}
@end
