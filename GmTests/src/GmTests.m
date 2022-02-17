//
//  GmTests.m
//  GmTests
//
//  Created by bytedance on 2022/2/16.
//

#import "gmtest.h"
#import <XCTest/XCTest.h>

@interface GmTests : XCTestCase

@end

@implementation GmTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    sm2test();
    sm3test();
    sm9test();
    zuctest();
    sms4test();
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
