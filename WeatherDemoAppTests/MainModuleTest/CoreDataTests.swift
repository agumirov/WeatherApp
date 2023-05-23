//
//  CoreDataTests.swift
//  WeatherDemoAppTests
//
//  Created by G G on 22.05.2023.
//

import Foundation
import XCTest
@testable import WeatherDemoApp

class CoreDataSaveTest: XCTestCase {
    
    func testSaveWeatherData() async {
        let mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                         country: "FR",
                                         latitude: 43.0226905,
                                         longitude: -0.4126314)
        
        let repository = RepositoryFactory.buildWeatherRepository()
        let weatherModel = try? await repository.getWeatherDataFromNetwork(geoData: mockGeoData) // saves data in storage after success call
        let storedData = try? await repository.getWeatherDataFromStorage()// when parameters are nil takes last call data from storage
        XCTAssertEqual(weatherModel?.name, mockGeoData.name)
        XCTAssertEqual(mockGeoData.name, storedData?.name)
        XCTAssertEqual(weatherModel?.name, storedData?.name)
    }
}

