//
//  gmFSTests.swift
//  gmFSTests
//
//  Created by jincaitian on 2022/2/14.
//

import XCTest
@testable import gmFS


class gmFSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        try testOCSM9Enc();
    }
    
    func testOCSM9Enc() throws {
        let sm9Enc=SM9Encryption("tianjincai");
//        let mData = NSData(base64Encoded: "this is a sentenct");
        let mData = Data(base64Encoded: "12345678")
        let encData = sm9Enc?.encrypt(mData)
        let decData = sm9Enc?.decrypt(encData)
        let mStr = mData?.base64EncodedString()
        let decStr = decData?.base64EncodedString()
        XCTAssertTrue(mStr!==decStr!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWifiConnector()throws{
        
    }
    


}
