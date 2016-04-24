//
//  CleanFileCacheManager.h
//  Jike
//
//  Created by jsonmess on 15/7/24.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^cleanFileBlock)();
@interface CleanFileCacheManager : NSObject
//清除缓存
+(void)cleanFileCacheSizeWithFinished:(cleanFileBlock)cleanBlock;
@end
