//
//  SM9.h
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

#ifndef SM9_h
#define SM9_h
#include <openssl/sm9.h>
#import <Foundation/Foundation.h>

@interface SM9Encryption : NSObject
@property SM9PublicParameters *mpk; // 公共参数
@property SM9MasterSecret *msk; // 主密钥
@property SM9PrivateKey *sk; // 私钥
@property const char *identification;

- (id)init:(NSString *)identification;// 构造函数
- (NSData *)encrypt:(NSData *)data;// 基本加密
- (NSData *)decrypt:(NSData *)data;// 基本解密
- (void)dealloc;// 析构函数
@end

#endif /* SM9_h */
