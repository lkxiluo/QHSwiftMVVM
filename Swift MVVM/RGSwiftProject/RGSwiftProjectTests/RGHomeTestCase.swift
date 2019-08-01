//
//  RGHomeTestCase.swift
//  RGSwiftProjectTests
//
//  Created by QianHan on 2019/7/17.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import XCTest

class RGHomeTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUrlRequest() {
        measure {
            let url = URL(string: "https://ios.devdon.com/")!
            let urlExpectation = expectation(description: "GET \(url)")
            
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                XCTAssert(data != nil, "data 不應該是 nil")
                XCTAssert(error == nil, "data 應當是 nil")
                
                if let response = response as? HTTPURLResponse,
                    let responseURL = response.url {
                    XCTAssert(responseURL.absoluteString == url.absoluteString, "URL變了")
                    XCTAssert(response.statusCode == 200, "response code 不是200")
                } else {
                    XCTFail()
                }
                
                urlExpectation.fulfill()
            }
            
            task.resume()
            
            waitForExpectations(timeout: task.originalRequest!.timeoutInterval, handler: { error in
                if let error = error {
                    print("網路請求時發生錯誤： \(error.localizedDescription)")
                }
                task.cancel()
            })
        }
    }
}
