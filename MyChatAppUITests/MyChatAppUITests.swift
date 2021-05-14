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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScrollOnMessageSubmit() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let messageTextField = app.textFields["Message..."]
        let messageScrollView = app.scrollViews["chatTable"]
        messageScrollView.swipeUp()
        messageScrollView.swipeUp()
        messageScrollView.swipeUp()

        messageTextField.tap()
        messageTextField.typeText("New value 1")
        app.keyboards.buttons["return"].tap()

        messageTextField.tap() // should break here because textfield should not dismiss on submission of data
        messageTextField.typeText("New value 2")
        app.keyboards.buttons["return"].tap()

        messageTextField.tap()
        messageTextField.typeText("New value 3")
        app.keyboards.buttons["return"].tap()

        // last message should be visible on the screen
        XCTAssertTrue(app.staticTexts["New value 3"].exists)
    }
}
