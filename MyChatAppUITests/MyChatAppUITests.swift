//
//  MyChatAppUITests.swift
//  MyChatAppUITests
//
//  Created by Zachary Burgess on 12/05/2021.
//

import XCTest

class MyChatAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScrollOnMessageSubmit() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let messageTextField = app.textFields["Message..."]
        let sendButton = app.buttons["Send"]
        let messageScrollView = app.scrollViews["chatTable"]
        messageScrollView.swipeUp()
        messageScrollView.swipeUp()
        messageScrollView.swipeUp()
        
        
        messageTextField.tap()
        messageTextField.typeText("New value 1")
        sendButton.tap()
        
        messageTextField.typeText("New value 2")
        sendButton.tap()
        
        messageTextField.typeText("New value 3")
        sendButton.tap()
        
        // last message should be visible on the screen
        XCTAssertTrue(app.staticTexts["New value 3"].exists)
        print(app)
    }
}
