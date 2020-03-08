//
//  task200202_02UITests.swift
//  task200202-02UITests
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import XCTest

class task200202_02UITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
        
    func testDeleteTextView() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["deleteTextViewTextButton"].tap()
        let textViewText: String = app.textViews["beforeConvertTextView"].value as! String
        XCTAssertEqual(textViewText, "")
    }
  
//    UITextView入力後にキーボードをしまう動作を設定する必要あり
//    func testConvertHiragana() {
//        let app = XCUIApplication()
//
//        app.launch()
//        app.textViews["beforeConvertTextView"].tap()
//        app.textViews["beforeConvertTextView"].typeText("今日は良い天気ですね")
//
//        app.buttons["convertHiraganaButton"].tap()
//
//        let convertedText: String = app.staticTexts["convertedTextLabel"].value as! String
//        XCTAssertEqual(convertedText, "きょうは よい てんきですね")
//    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
