//
//  GmSSLService.m
//  gmFS
//
//  Created by jincaitian on 2022/5/1.
//

#import <Foundation/Foundation.h>
#import "GmSSLService.h"
#import <sm3.h>
#import <sm4.h>
@implementation GmService
- (instancetype)init:(NSString *) name email:(NSString *)email
{
    self = [super init];
    if (self) {
        NSString *concat = [NSString stringWithFormat:@"%@%@",name,email];
        NSData *data= [concat dataUsingEncoding:NSUTF8StringEncoding];
        NSInteger len = [data length];
        const void *bytes =[data bytes];
        uint8_t dgst[SM3_DIGEST_SIZE];
        uint8_t *ut8Data = (uint8_t *)bytes;
        sm3_digest(ut8Data, len, dgst);
        printf("%s",dgst);
        sm4_set_encrypt_key(&enc_key, dgst);
        sm4_set_decrypt_key(&dec_key, dgst);
    }
    return self;
}

- (NSData *)sm4_enc:(NSData *)data{
    uint8_t iv[SM4_GCM_IV_DEFAULT_SIZE];
    NSInteger len = [data length];
    uint8_t enc_out[2*len];
    size_t out_len;
    sm4_cbc_padding_encrypt(&enc_key, iv, (uint8_t *)[data bytes], len, enc_out, &out_len);
    return [NSData dataWithBytes:(const void *)enc_out length:out_len];
}


- (NSData *)sm4_dec:(NSData *)enc_data{
    uint8_t iv[SM4_GCM_IV_DEFAULT_SIZE];
    NSInteger len = [enc_data length];
    uint8_t dec_out[2*len];
    size_t dec_out_len;
    sm4_cbc_padding_decrypt(&dec_key, iv, (uint8_t *)[enc_data bytes], len, dec_out, &dec_out_len);
    return [NSData dataWithBytes:(const void *)dec_out length:dec_out_len];
}


@end
