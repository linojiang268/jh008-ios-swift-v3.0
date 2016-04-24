//
//  UseQiNiu.m
//  Jike
//
//  Created by Iosmac on 15/9/7.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import "UseSign.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation UseSign

-(NSString *)createSign:(NSDictionary *)dic kSignKey:(NSString *)kSignKey {
    NSArray *array =[dic allKeys];
    NSArray *kays = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *resultStr = [NSMutableString string];
    NSString *signKey = [NSString stringWithFormat:@"key=%@",kSignKey];
    [resultStr appendString:signKey];
    for (NSString *key in kays) {
        
        [resultStr appendString:@"&"];
        
        id value = dic[key];
        if ([value isKindOfClass:[NSNumber class]]) {
            [resultStr appendString:[NSString stringWithFormat:@"%@=%@",key,[self encodeURL:[value stringValue]]]];
        }else {
            if([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSMutableArray class]]){
                //DDLogInfo(@"%@ is a array, skip sign", key);
                continue;
            }
            [resultStr appendString:[NSString stringWithFormat:@"%@=%@",key,[self encodeURL:value]]];
        }
    }
    
    return [self sha512:resultStr];
}

- (NSString *)sha512:(NSString *)param
{
    const char *cstr = [param cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:param.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*)encodeURL:(NSString *)string {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[string UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
