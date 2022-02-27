//
//  SM9.m
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

#import <Foundation/Foundation.h>
#import <openssl/sm9.h>
#import <openssl/err.h>
#import <Util/typeConvert.h>
#import "SM9.h"

@implementation SM9Encryption

- (id)init:(NSString *)identification
{
    _identification = [Util nsStringToCharArr:identification];
    if(self=[super init]){
        if(!(SM9_setup(NID_sm9bn256v1, NID_sm9encrypt, NID_sm9hash1_with_sm3, &_mpk, &_msk))){
            ERR_print_errors_fp(stderr);
            return nil;
        }
        if (!(_sk=SM9_extract_private_key(_msk, _identification, strlen(_identification)))){
            ERR_print_errors_fp(stderr);
            return nil;
        }
    }
    return self;
}

- (NSData *)encrypt:(NSData *)data{
    unsigned char *in = [Util nsDataToCharArr:data];
    unsigned char out[1024];
    size_t outlen;
    if(!(SM9_encrypt(NID_sm9encrypt_with_sm3_xor, in, data.length, out, &outlen, _mpk, _identification, strlen(_identification)))){
        ERR_print_errors_fp(stderr);
        return nil;
    }
    return [Util charArrToNSData:out len:outlen];
}

- (NSData *)decrypt:(NSData *)data{
  return nil
}

@end

