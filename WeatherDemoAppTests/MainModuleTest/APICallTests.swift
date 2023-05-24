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
    let networkService = NetworkServiceImplementation()
    
    func testFetchingGeoData() async {
        let expectation: [GeoModelAPI] = [.mock]
        let result = try? await networkService.getGeoData(cityName: "London")
        XCTAssertEqual(expectation.first, result?.first)
    }
    
    func testFetchingWeatherData() async {
        let result = try? await networkService.getWeatherData(geoData: .mock)
        XCTAssertNotNil(result)
    }
}
