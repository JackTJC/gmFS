//
//  GmSSLService.h
//  gmFS
//
//  Created by jincaitian on 2022/5/1.
//

#ifndef GmSSLService_h
#define GmSSLService_h
#import <sm4.h>
#import <Foundation/Foundation.h>
@interface GmService : NSObject{
    SM4_KEY enc_key;
    SM4_KEY dec_key;
}
- (instancetype)init:(NSString *) name email:(NSString *) email;
- (NSData *)sm4_enc:(NSData *)data;
- (NSData *)sm4_dec:(NSData *)enc_data;
@end
#endif /* GmSSLService_h */
