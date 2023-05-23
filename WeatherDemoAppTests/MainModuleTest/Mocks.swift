//
//  Mocks.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
@testable import WeatherDemoApp

class MockWeatherRepository: WeatherRepository {
    
    func getWeatherDataFromStorage() async throws -> WeatherDemoApp.WeatherModelDomain {
        throw NetworkServiceErrors.badRequest
    }
    
    func getWeatherDataFromNetwork(geoData: WeatherDemoApp.GeoModelDomain?) async throws -> WeatherDemoApp.WeatherModelDomain {
        throw NetworkServiceErrors.badRequest
    }
}
