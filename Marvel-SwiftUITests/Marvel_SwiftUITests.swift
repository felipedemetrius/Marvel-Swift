//
//  Marvel_SwiftUITests.swift
//  Marvel-SwiftUITests
//
//  Created by Felipe Silva  on 17/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import XCTest

class Marvel_SwiftUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.

    }

    func testUI() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        app.launch()

        sleep(3)

        app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["3-D Man"]/*[[".cells.staticTexts[\"3-D Man\"]",".staticTexts[\"3-D Man\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.staticTexts["Unavailable"].swipeUp()

        let element = elementsQuery.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element
        element.swipeLeft()
        element.swipeLeft()
        scrollViewsQuery.otherElements.containing(.staticText, identifier: "Description").element.swipeUp()
        app.navigationBars["3-D Man"].buttons["Characters Marvel"].tap()

        app.tables.element.swipeDown()
        app.tables.element.swipeDown()
        app.tables.element.swipeDown()
        app.tables.element.swipeDown()

        app.tables.element.swipeUp()
        app.tables.element.swipeUp()
        app.tables.element.swipeUp()
        app.tables.element.swipeUp()
    }
}
