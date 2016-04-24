//
//  AssetHelper.m
//  Demo
//
//  Created by ysq on 14/7/2.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import "AssetHelper.h"

@implementation AssetHelper{
    ALAssetsLibrary *_assetsLibrary;
    NSMutableArray *_groupArray;
    NSMutableArray *_assetArray;
}


+(id)shareInstance{
    static AssetHelper *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AssetHelper alloc]init];
        [_instance initAsset];
    });
    return _instance;
}

-(void)initAsset{
    _assetsLibrary = [[ALAssetsLibrary alloc]init];
    _assetArray = [[NSMutableArray alloc]init];
}

-(void)getGroup:(void(^)(NSArray *))resultBlock{
    _groupArray = [[NSMutableArray alloc]init];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (!group) {
            resultBlock([_groupArray copy]);
            return;
        }
        [_groupArray addObject:group];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Enumerate the asset groups failed.");
    }];
}


- (NSDictionary *)getGroupInfo:(ALAssetsGroup *)group
{
    return @{@"name" : [group valueForProperty:ALAssetsGroupPropertyName],
             @"count" : @([group numberOfAssets]),
             @"thumbnail" : [UIImage imageWithCGImage:[group posterImage]]};
}

-(void)getAssetWithGroup:(ALAssetsGroup *)group result:(void(^)(NSArray *))resultBlock{
   
    _assetArray = [[NSMutableArray alloc]init];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
        if(!result){
            resultBlock([_assetArray copy]);
            return;
        }
        if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
            [_assetArray addObject:result];
        }
    }];
    
}

- (UIImage *)getAssetThumbnail:(ALAsset *)asset{
    return [UIImage imageWithCGImage:asset.thumbnail];
}

- (UIImage *)getAssetFullScreenImage:(ALAsset *)asset{
    return [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
}
- (NSURL *)getAssetImageUrl:(ALAsset *)asset{
    return asset.defaultRepresentation.url;
}


@end
