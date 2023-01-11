//
//  RocketModuleTests.swift
//  RocketAppTests
//
//  Created by Кирилл on 11.01.2023.
//

import XCTest
@testable import RocketApp

final class RocketModuleTests: XCTestCase {
    var networkService: MockNetworkService!
    var rocketPageViewController: RocketPageViewController!
    var rocketPresenter: RocketPresenter!
    var rocketModel: Rocket!
    
    override func setUpWithError() throws {
        networkService = MockNetworkService()
        rocketPresenter = RocketPresenter(networkService: networkService)
        rocketPageViewController = RocketPageViewController(presenter: rocketPresenter)
        rocketModel = Rocket(height: .init(meters: 0.3, feet: 0.4), diameter: .init(meters: 0.3, feet: 0.4), mass: .init(kg: 3, lb: 4), firstStage: .init(engines: 3, fuelAmountTons: 2, burnTimeSec: 2), secondStage: .init(engines: 4, fuelAmountTons: 1, burnTimeSec: 1), payloadWeights: [.init(id: "baz", name: "foo", kg: 30, lb: 20)], flickrImages: ["baz"], name: "foo", costPerLaunch: 300, firstFlight: "baz", country: "bar", id: "123")
    }

    override func tearDownWithError() throws {
        networkService = nil
        rocketPresenter = nil
        rocketPageViewController = nil
        rocketModel = nil
    }
    
    func testRocketPageViewBuilderNotNil() throws {
        let rocketView = RocketViewBuilderImpl.buildViews(for: rocketModel)
        XCTAssertNotNil(rocketView)
    }
    
    func testRocketPageViewControllerViewCount() throws {
        // Given
        let expectedResult = 1
        var validateResult: Int?
        let validatorExpectation = expectation(description: "Expectation in " + #function)
        
        // When
        rocketPageViewController.viewDidLoad()
        DispatchQueue.main.async {
            validateResult = self.rocketPageViewController.viewControllers?.count
            validatorExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            XCTAssertEqual(expectedResult, validateResult)
        }
    }
    
    func testRocketPresenterSetViewNotNil() throws {
        // Given
        let rocketViewController = RocketViewController(rocket: rocketModel)
        
        // When
        rocketPresenter.view = rocketPageViewController
        rocketPresenter.view?.setView(view: rocketViewController)
        
        // Then
        XCTAssertNotNil(rocketPageViewController.viewControllers)
    }
}
