//
//  LaunchesModuleTests.swift
//  RocketAppTests
//
//  Created by Кирилл on 12.01.2023.
//

import XCTest
@testable import RocketApp

// swiftlint:disable all
final class LaunchesModuleTests: XCTestCase {
    var networkService: MockNetworkService!
    var launchModel: LaunchElement!
    var launchesPresenter: LaunchesPresenter!
    var launchesViewController: LaunchesViewController!

    override func setUpWithError() throws {
        networkService = MockNetworkService()
        launchModel = LaunchElement(name: "Foo", dateLocal: "2023-01-11T19:12:00+0600", rocket: "rocket", success: true)
        launchesPresenter = LaunchesPresenter(rocketId: "rocket")
        launchesPresenter.networkService = networkService
        launchesViewController = LaunchesViewController(presenter: launchesPresenter)
    }

    override func tearDownWithError() throws {
        networkService = nil
        launchModel = nil
        launchesPresenter = nil
        launchesViewController = nil
    }

    func testLaunchesCount() throws {
        // Given
        let expectedResult = 1
        var result: Int?
        let validatorExpectation = expectation(description: "Expectation in " + #function)
        
        // When
        launchesViewController.viewDidLoad()
        DispatchQueue.main.async {
            result = self.launchesPresenter.launches.count
            validatorExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(expectedResult, result)
        }
    }
}
