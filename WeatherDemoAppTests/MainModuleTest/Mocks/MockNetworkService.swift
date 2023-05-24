//
//  MockNetworkService.swift
//  WeatherDemoAppTests
//
//  Created by G G on 24.05.2023.
//

import Foundation
@testable import WeatherDemoApp

typealias GeoCompletion = () -> Void
typealias WeatherCompletion = () -> Void

class MockNetworkService: NetworkService {
    
    private let geoCompletion: GeoCompletion
    private let weatherCompletion: WeatherCompletion
    
    init(
        geoCompletion: @escaping GeoCompletion,
        weatherCompletion: @escaping WeatherCompletion
    ) {
        self.geoCompletion = geoCompletion
        self.weatherCompletion = weatherCompletion
    }
    
    func getWeatherData(geoData: WeatherDemoApp.GeoModelDomain) async throws -> WeatherDemoApp.WeatherModelAPI {
        weatherCompletion()
        return .mock
    }
    
    func getGeoData(cityName: String) async throws -> [WeatherDemoApp.GeoModelAPI] {
        weatherCompletion()
        return [.mock]
    }
}
