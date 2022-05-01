//
//  gmFSTests.swift
//  gmFSTests
//
//  Created by jincaitian on 2022/2/14.
//

import XCTest
import Foundation
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
        NSLog("dir:%@",NSHomeDirectory())
        
    }
    
    // local cache test
    func testSet()throws{
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: "user_cache")
        userDefault.synchronize()
    }
    
    func testGet()throws{
        let token = UserDefaults.standard.object(forKey: "user_cache")
        print(token!)
    }

    // enc test
    func testSm4Enc()throws{
        let service = GmService("tianjincai", email: "tianjincai@hotmail.com")
        let testStr = "this is a test data fo sm4 enc"
        let data = testStr.data(using: .utf8)!
        let encData = service?.sm4_enc(data)
        print(encData?.base64EncodedString())
        let decData = service?.sm4_dec(encData!)
        print(String(data: decData!, encoding: .utf8))
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
