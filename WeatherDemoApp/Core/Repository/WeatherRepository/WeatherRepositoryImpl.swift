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
    
    func getWeatherData(geoData: GeoModelDomain?) async throws -> WeatherModelDomain {
        do {
            let result = try await geoData == nil ? getWeatherDataFromStorage() :
            getWeatherDataFromNetwork(geoData: geoData)
            return result
        } catch let (error) {
            throw error
        }
    }
}

extension WeatherRepositoryImpl {
    
    private func getWeatherDataFromStorage() async throws -> WeatherModelDomain {
        let storedData = try weatherStorageManager.fetchData()
        guard let weatherData = storedData.last else { throw StorageErrors.fetchingFailed }
        print(weatherData)
        let weatherModel = WeatherModelDomain(coreDataModel: weatherData)
        
        return weatherModel
    }
    
    private func getWeatherDataFromNetwork(geoData: GeoModelDomain?) async throws -> WeatherModelDomain {
        guard let geoData = geoData else { fatalError("Data is nil") }
        let apiModel = try await networkService.getWeatherData(geoData: geoData)
        let weatherModel = WeatherModelDomain(location: geoData, weather: apiModel)
        try weatherStorageManager.saveData(weatherModel: weatherModel)
        
        return weatherModel
    }
}
