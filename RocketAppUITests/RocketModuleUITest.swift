//
//  RocketModuleUITest.swift
//  RocketAppUITests
//
//  Created by Кирилл on 12.01.2023.
//

import XCTest
@testable import RocketApp

final class RocketModuleUITest: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testShowingSettingScreenAndClose() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        let settingButton = elementsQuery.scrollViews.otherElements.buttons["Setting"]
        settingButton.tap()
        
        let staticText = elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Закрыть"]/*[[".buttons[\"Закрыть\"].staticTexts[\"Закрыть\"]",".staticTexts[\"Закрыть\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        settingButton.tap()
        staticText.tap()
    }
    
    func testShowLaunchesScreenAndClose() throws {
        let app = XCUIApplication()
        app.launch()
        let button = app.scrollViews.otherElements.scrollViews.otherElements.buttons["Посмотреть запуски"]
        button.tap()
        
        let backButton = app.navigationBars["Falcon 1"].buttons["Back"]
        backButton.tap()
        button.tap()
        backButton.tap()
    }
}
