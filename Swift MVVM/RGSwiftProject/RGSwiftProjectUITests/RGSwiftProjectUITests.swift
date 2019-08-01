//
//  RGSwiftProjectUITests.swift
//  RGSwiftProjectUITests
//
//  Created by QianHan on 2019/7/12.
//  Copyright © 2019 karl.luo. All rights reserved.
//

import XCTest

class RGSwiftProjectUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
    }

    func testExample() {
        app.buttons["Slide"].tap()
        app.staticTexts["Get as close as you can to: "].tap()
    }
    
    func testLabel() {
        
    }
    
    func testButtonAction() {
        
    }
}
