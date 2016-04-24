//
//  AssetHelper.h
//  Demo
//
//  Created by ysq on 14/7/2.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define ASSETHELPER  [AssetHelper shareInstance]


@interface AssetHelper : NSObject

+(id)shareInstance;
-(void)getGroup:(void(^)(NSArray *))resultBlock;
- (NSDictionary *)getGroupInfo:(ALAssetsGroup *)group;
-(void)getAssetWithGroup:(ALAssetsGroup *)group result:(void(^)(NSArray *))resultBlock;
- (UIImage *)getAssetThumbnail:(ALAsset *)asset;
- (UIImage *)getAssetFullScreenImage:(ALAsset *)asset;
- (NSURL *)getAssetImageUrl:(ALAsset *)asset;
@end

