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
    
    func getWeatherDataFromStorage() async throws -> WeatherModelDomain {
        
        let storedData = weatherStorageManager.fetchData()
        guard let weatherData = storedData.last else { throw StorageErrors.fetchingFailed }
        print(weatherData)
        let weatherModel = WeatherModelDomain(coreDataModel: weatherData)
        
        return weatherModel
    }
    
    func getWeatherDataFromNetwork(geoData: GeoModelDomain?) async throws -> WeatherModelDomain {
        
        guard let geoData = geoData else { fatalError("Data is nil") }
        let apiModel = try await networkService.getWeatherData(geoData: geoData)
        let weatherModel = WeatherModelDomain(location: geoData, weather: apiModel)
        weatherStorageManager.saveData(weatherModel: weatherModel)
        
        return weatherModel
    }
}
