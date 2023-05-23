//
//  CoordinatorTest.swift
//  WeatherDemoAppTests
//
//  Created by G G on 22.05.2023.
//

import Foundation
import XCTest
@testable import WeatherDemoApp

class CoordinatorTests: XCTestCase {
    let coordinator = CoordinatorFactory.buildCoordinator()
    
    func testStartWithStoredData() {
        coordinator.start()
        XCTAssert(coordinator.navigationController.visibleViewController is WeatherViewController)
    }
    
    func testWeatherScreenShowing() {
        coordinator.showWeatherScreen(geoData: nil)
        XCTAssert(coordinator.navigationController.visibleViewController is WeatherViewController)
    }
    
    func testSearchScreenShowing() {
        coordinator.showSearchScreen()
        XCTAssert(coordinator.navigationController.visibleViewController is SearchViewController)
    }
}
