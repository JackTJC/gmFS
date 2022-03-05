//
//  Header.h
//  gmFS
//
//  Created by bytedance on 2022/2/27.
//

#ifndef Header_h
#define Header_h
#include <Foundation/Foundation.h>
@interface Util:NSObject
+ (const char *)nsStringToCharArr:(NSString *)s;
+ (NSString *)charArrToNSString:(const char *)s;
+ (unsigned char *)nsDataToCharArr:(NSData *)data;
+ (NSData *)charArrToNSData:(unsigned char *)data len:(size_t)len;
@end

#endif /* Header_h */
