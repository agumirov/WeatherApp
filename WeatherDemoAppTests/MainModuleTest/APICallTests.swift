//
//  APICallTests.swift
//  WeatherDemoAppTests
//
//  Created by G G on 22.05.2023.
//

import Foundation

import XCTest
@testable import WeatherDemoApp

class APICallsTest: XCTestCase {

    func testFetchingWeatherData() async {
        let networkService = NetworkServiceImplementation()
        let mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                         country: "FR",
                                         latitude: 43.0226905,
                                         longitude: -0.4126314)
        
        let modelAPI = try? await networkService.getWeatherData(geoData: mockGeoData)
        XCTAssertNotNil(modelAPI)
    }
    
    func testFetchingGeoData() async {
        let networkService = NetworkServiceImplementation()
        let modelAPI = try? await networkService.getGeoData(cityName: "Aste")
        XCTAssertNotNil(modelAPI)
    }
}
