//
//  ALAsset+Eq.m
//  Demo
//
//  Created by ysq on 14/7/2.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import "ALAsset+Equal.h"

@implementation ALAsset (Equal)
-(BOOL)isEqual:(ALAsset *)object{
    if ([self.defaultRepresentation.url isEqual:object.defaultRepresentation.url]) {
        return YES;
    }
    return NO;
}
@end
