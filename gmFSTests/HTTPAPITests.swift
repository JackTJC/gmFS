//
//  HTTPAPITests.swift
//  gmFSTests
//
//  Created by bytedance on 2022/3/17.
//

import XCTest
@testable import gmFS


class HTTPAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWifiConnector()throws{
        
    }
    
    func testHTTPAPI()throws{
        HTTPAPI("baidu.com")
            .withProtocol(.HTTPS)
            .withUri("/")
            .withMethod(.POST)
            .doRequest()
    }
    


}
