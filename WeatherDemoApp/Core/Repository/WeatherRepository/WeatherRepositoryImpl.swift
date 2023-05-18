//
//  WeatherRepositoryImpl.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

class WeatherRepositoryImpl: WeatherRepository {
    
    private let networkService: NetworkService
    private let weatherStorageManager: WeatherStorageManager
    
    init(networkService: NetworkService,
         weatherStorageManager: WeatherStorageManager) {
        self.networkService = networkService
        self.weatherStorageManager = weatherStorageManager
    }
    
    func getWeatherData(geoData: GeoModelDomain?) async throws -> WeatherModelDomain? {
        
        var apiModel: WeatherModelAPI
        
        if geoData == nil {
            let storedData = weatherStorageManager.fetchData()
            guard let geodData = storedData.last else { return nil }
            apiModel = try await networkService.getWeatherData(geoData: GeoModelDomain(from: geodData))
        }
        
        guard let geoData = geoData else { fatalError("data is nil") }
        weatherStorageManager.saveData(geoData: geoData)
        apiModel = try await networkService.getWeatherData(geoData: geoData)
        
        let weatherModel = WeatherModelDomain(location: geoData,
                                              weather: apiModel)
        return weatherModel
    }
}
