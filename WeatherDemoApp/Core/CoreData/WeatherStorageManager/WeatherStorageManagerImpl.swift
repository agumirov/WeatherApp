//
//  WeatherStorageManager.swift
//  WeatherDemoApp
//
//  Created by G G on 17.05.2023.
//

import Foundation
import CoreData

class WeatherStorageManagerImpl: StorageManager, WeatherStorageManager {
    
    func saveData(geoData: GeoModelDomain) {
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: context) else { return }
        let weatherData = WeatherModelCD(entity: entity, insertInto: context)
        weatherData.city = geoData.name
        weatherData.country = geoData.country
        weatherData.longitude = (geoData.longitude) as NSNumber
        weatherData.latitude = (geoData.latitude) as NSNumber
        
        saveContext()
    }
    
    func fetchData() -> [WeatherModelCD] {
        let fetchRequest: NSFetchRequest<WeatherModelCD> = WeatherModelCD.fetchRequest()
        guard let objects = try? context.fetch(fetchRequest) else { return [] }
        
        return objects
    }
    
    func updateData(geoData: GeoModelDomain) {
        let weatherData = WeatherModelCD(context: context)
        weatherData.city = geoData.name
        weatherData.country = geoData.country
        weatherData.longitude = (geoData.longitude) as NSNumber
        weatherData.latitude = (geoData.latitude) as NSNumber
        
        saveContext()
    }
    
    func deletaAllData() {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        try! context.execute(batchDeleteRequest)
    }
}
