//
//  typeConvert.m
//  gmFS
//
//  Created by bytedance on 2022/2/27.
//

#import <Foundation/Foundation.h>
#import "typeConvert.h"

/*
  reference from: https://blog.krybot.com/a?ID=01350-ace36364-63fe-4781-abf6-5fdf340a3fe2
 */
@implementation Util

+ (NSString *)charArrToNSString:(const char *)s{
    return [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
}

+ (const char *)nsStringToCharArr:(NSString *)s{
    return [s UTF8String];
}

+ (NSData *)charArrToNSData:(unsigned char *)data len:(size_t)len{
    return [NSData dataWithBytes:data length:len];
}

+ (unsigned char *)nsDataToCharArr:(NSData *)data{
    return (unsigned char *)[data bytes];
}

@end
