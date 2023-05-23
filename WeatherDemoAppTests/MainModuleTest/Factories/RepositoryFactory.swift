//
//  RepositoryFactory.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
@testable import WeatherDemoApp

enum RepositoryFactory {
    static func buildWeatherRepository() -> WeatherRepository {
        let networkService = NetworkServiceImplementation()
        let storageManager = WeatherStorageManagerImpl()
        let repository = WeatherRepositoryImpl(
            networkService: networkService,
            weatherStorageManager: storageManager)
        
        return repository
    }
    
    static func buildGeoRepository() -> GeoRepository {
        let networkService = NetworkServiceImplementation()
        let repository = GeoRepositoryImpl(networkService: networkService)
        
        return repository
    }
}
