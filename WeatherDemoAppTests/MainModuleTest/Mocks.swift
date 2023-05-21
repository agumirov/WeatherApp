//
//  Mocks.swift
//  WeatherDemoAppTests
//
//  Created by G G on 22.05.2023.
//

import Foundation
@testable import WeatherDemoApp

extension MainModuleTest {
    class MockNetworkService: NetworkService {
        
        func getWeatherData(geoData: WeatherDemoApp.GeoModelDomain) async throws -> WeatherDemoApp.WeatherModelAPI {
            return WeatherModelAPI(list: [])
        }
        
        func getGeoData(cityName: String) async throws -> [WeatherDemoApp.GeoModelAPI] {
            let mockGeoData = GeoModelAPI(name: "Aste-Béon",
                                          latitude: -0.4126314,
                                          longitude: 43.0226905,
                                          country: "FR")
            return [mockGeoData]
        }
        
        
    }
    
    class MockWeatherRepository: WeatherRepository {
        func getWeatherData(geoData: WeatherDemoApp.GeoModelDomain?) async throws -> WeatherDemoApp.WeatherModelDomain? {
            let geoModelAPI = GeoModelAPI(name: "Aste-Béon",
                                          latitude: -0.4126314,
                                          longitude: 43.0226905,
                                          country: "FR")
            
            return WeatherModelDomain(location: GeoModelDomain(from: geoModelAPI), weather: WeatherModelAPI(list: []))
        }
    }
}
