//
//  WeatherStorageManager.swift
//  WeatherDemoApp
//
//  Created by G G on 17.05.2023.
//

import Foundation
import CoreData

class WeatherStorageManagerImpl: StorageManager, WeatherStorageManager {
    
    func saveData(weatherModel: WeatherModelDomain) throws {
        deletaAllData()
        guard let weatherModelEntity = NSEntityDescription.entity(
            forEntityName: "WeatherModelCD",
            in: context
        ) else { throw StorageErrors.savingFailed }
        
        let weatherData = WeatherModelCD(entity: weatherModelEntity, insertInto: context)
        weatherData.city = weatherModel.name
        weatherData.country = weatherModel.country
        weatherData.icon = weatherModel.icon
        weatherData.date = weatherModel.date
        weatherData.temperature = weatherModel.temperature
        weatherData.humidity = weatherModel.humidity
        weatherData.pressure = weatherModel.pressure
        weatherData.windspeed = weatherModel.windspeed
        weatherData.visibility = weatherModel.visibility
        weatherData.list = weatherModel.list
        
        saveContext()
    }
    
    func fetchData() throws -> [WeatherModelCD] {
        let fetchRequest: NSFetchRequest<WeatherModelCD> = WeatherModelCD.fetchRequest()
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch {
//            fatalError("Failed to fetch entities: \(error)")
            throw StorageErrors.fetchingFailed
        }
    }
    
    func deletaAllData() {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherModelCD")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        try! context.execute(batchDeleteRequest)
    }
}
