//
//  MockWeatherRepository.swift
//  WeatherDemoAppTests
//
//  Created by G G on 24.05.2023.
//

import Foundation
@testable import WeatherDemoApp

class MockWeatherRepository: WeatherRepository {
    var withError: Bool
    
    init(withError: Bool) {
        self.withError = withError
    }
    func getWeatherData(geoData: WeatherDemoApp.GeoModelDomain?) async throws -> WeatherDemoApp.WeatherModelDomain {
        switch withError {
        case true:
            throw NetworkServiceErrors.badRequest
        case false:
            return .mock
        }
    }
}
