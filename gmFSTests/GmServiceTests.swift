//
//  GmServiceTests.swift
//  gmFSTests
//
//  Created by jincaitian on 2022/4/9.
//

import XCTest

class GmServiceTests: XCTestCase {

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
    }
    
    func testService()throws{
        let s = GmService("tianjincai",email: "tianjincai@hotmail.com")
        let dataStr = "this is my test data"
        let data = Data(dataStr.utf8)
        let encData = s?.sm4_enc(data)
        print(encData?.base64EncodedString())
        let decData = s?.sm4_dec(encData)
        print(String(data: decData!, encoding: .utf8)!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
