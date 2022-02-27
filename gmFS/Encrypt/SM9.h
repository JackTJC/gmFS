//
//  SM9.h
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

#ifndef SM9_h
#define SM9_h
#include <openssl/sm9.h>

@interface SM9Encryption : NSObject
@property SM9PublicParameters *mpk;
@property SM9MasterSecret *msk;
@property SM9PrivateKey *sk;
@property const char *identification;

- (id)init:(NSString *)identification;
- (NSData *)encrypt:(NSData *)data;
- (NSData *)decrypt:(NSData *)data;

@end

#endif /* SM9_h */
