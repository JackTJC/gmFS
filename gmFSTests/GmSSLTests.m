//
//  GmSSLTests.m
//  gmFSTests
//
//  Created by bytedance on 2022/4/9.
//

#import <XCTest/XCTest.h>
#import <sm3.h>
#import <sm4.h>
@interface GmSSLTests : XCTestCase

@end

@implementation GmSSLTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void) testSM3{
    NSData *data = [@"this is my test data" dataUsingEncoding:NSUTF8StringEncoding];
    const void *bytes = [data bytes];
    int len = [data length];
    uint8_t *upt8Data = (uint8_t *)bytes;
    uint8_t dgst[32];
    sm3_digest(upt8Data, len, dgst);
}

- (void) testSM4{
    // digest
    NSData *data = [@"this is my test data" dataUsingEncoding:NSUTF8StringEncoding];
    const void *bytes = [data bytes];
    int len = [data length];
    uint8_t *upt8Data = (uint8_t *)bytes;
    uint8_t dgst[32];
    sm3_digest(upt8Data, len, dgst);
    // key prepare
    SM4_KEY enc_key,dec_key;
    sm4_set_encrypt_key(&enc_key, dgst);
    sm4_set_decrypt_key(&dec_key, dgst);
    uint8_t iv[16];

    uint8_t enc_out[32];
    size_t enc_out_len;
    sm4_cbc_padding_encrypt(&enc_key, iv, upt8Data, len, enc_out, &enc_out_len);
    
    uint8_t dec_out[32];
    size_t dec_out_len;
    sm4_cbc_padding_decrypt(&dec_key, iv, enc_out, enc_out_len, dec_out,&dec_out_len);
    
    printf("%s",dec_out);
    printf("%s",upt8Data);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
