//
//  WeatherViewModelFactory.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
@testable import WeatherDemoApp

enum WeatherViewModelBuilder {
    static func buildViewModel() -> WeatherViewModel {
        let mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                         country: "FR",
                                         latitude: 43.0226905,
                                         longitude: -0.4126314)
        let repository = RepositoryFactory.buildWeatherRepository()
        let storageManager = WeatherStorageManagerImpl()
        let viewModel = WeatherViewModelImpl(input: .init(geoData: mockGeoData),
                                             weatherRepository: repository,
                                             weatherStorageManager: storageManager)
        return viewModel
    }
    
    static func buildViewModelWithMockRepo() -> WeatherViewModel {
        let mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                         country: "FR",
                                         latitude: 43.0226905,
                                         longitude: -0.4126314)
        let repository = MockWeatherRepository()
        let storageManager = WeatherStorageManagerImpl()
        let viewModel = WeatherViewModelImpl(input: .init(geoData: mockGeoData),
                                             weatherRepository: repository,
                                             weatherStorageManager: storageManager)
        return viewModel
    }
}
