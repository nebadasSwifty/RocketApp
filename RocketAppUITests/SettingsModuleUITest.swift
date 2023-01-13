//
//  SettingsModuleUITest.swift
//  RocketAppUITests
//
//  Created by Кирилл on 12.01.2023.
//

import XCTest
// swiftlint:disable all
final class SettingsModuleUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testOpenSettingsScreenAndChangeParameterAndClose() throws {
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.scrollViews.otherElements.buttons["Setting"].tap()
        
        let element2 = scrollViewsQuery.children(matching: .other).element(boundBy: 0)
        let element = element2.children(matching: .other).element(boundBy: 2)
        element/*@START_MENU_TOKEN@*/.buttons["ft"]/*[[".segmentedControls.buttons[\"ft\"]",".buttons[\"ft\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element2.children(matching: .other).element(boundBy: 4)/*@START_MENU_TOKEN@*/.buttons["lb"]/*[[".segmentedControls.buttons[\"lb\"]",".buttons[\"lb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element/*@START_MENU_TOKEN@*/.buttons["m"]/*[[".segmentedControls.buttons[\"m\"]",".buttons[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Закрыть"]/*[[".buttons[\"Закрыть\"].staticTexts[\"Закрыть\"]",".staticTexts[\"Закрыть\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
