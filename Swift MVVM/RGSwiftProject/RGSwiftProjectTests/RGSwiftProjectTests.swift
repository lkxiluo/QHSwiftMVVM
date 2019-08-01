//
//  RGSwiftProjectTests.swift
//  RGSwiftProjectTests
//
//  Created by QianHan on 2019/7/12.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import XCTest

@testable import RGSwiftProject

class RGSwiftProjectTests: XCTestCase {

    var vc: ViewController = ViewController();
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
    
    func testUnLock() {
        for m in 0...10 {
            for n in 0...10 {
                let isUnlock = vc.isUnlockSuccess(number1: m, number2: n)
                if m == 3 && n == 7 {
                    XCTAssertTrue(isUnlock == true)
                } else {
                    XCTAssert(isUnlock == false, "\(m) - \(n) 解锁了!")
                }
            }
        }
    }
    
    func testUnLockMeasure() {
        measure {
            for m in 0...1000 {
                for n in 0...1000 {
                    let isUnlock = vc.isUnlockSuccess(number1: m, number2: n)
                    if m == 3 && n == 7 {
                        XCTAssertTrue(isUnlock == true)
                    } else {
                        XCTAssert(isUnlock == false, "\(m) - \(n) 解锁了!")
                    }
                }
            }
        }
    }
}
