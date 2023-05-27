//
//  APICallTests.swift
//  WeatherDemoAppTests
//
//  Created by G G on 22.05.2023.
//

import Foundation

import XCTest
@testable import WeatherDemoApp

class APICallsTests: XCTestCase {
    let networkService = MockNetworkService(geoCompletion: {}, weatherCompletion: {})
    
    func testFetchingGeoData() async {
        let expectation: [GeoModelAPI] = [.mock]
        let result = try? await networkService.getGeoData(cityName: "testCall")
        XCTAssertEqual(expectation, result)
    }
    
    func testFetchingWeatherData() async {
        let expectation: WeatherModelAPI = .mock
        let result = try? await networkService.getWeatherData(geoData: .mock)
        XCTAssertEqual(expectation, result)
    }
}
