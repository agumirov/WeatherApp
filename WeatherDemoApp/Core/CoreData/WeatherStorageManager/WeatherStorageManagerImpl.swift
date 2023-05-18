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
        deletaAllData()
        guard let entity = NSEntityDescription.entity(forEntityName: "GeoModelCD", in: context) else { return }
        let weatherData = GeoModelCD(entity: entity, insertInto: context)
        weatherData.city = geoData.name
        weatherData.country = geoData.country
        weatherData.longitude = (geoData.longitude) as NSNumber
        weatherData.latitude = (geoData.latitude) as NSNumber
        
        super.saveContext()
    }
    
    func fetchData() -> [GeoModelCD] {
        let fetchRequest: NSFetchRequest<GeoModelCD> = GeoModelCD.fetchRequest()
        guard let objects = try? context.fetch(fetchRequest) else { return [] }
        return objects
    }
    
    func updateData(geoData: GeoModelDomain) {
        let weatherData = GeoModelCD(context: context)
        weatherData.city = geoData.name
        weatherData.country = geoData.country
        weatherData.longitude = (geoData.longitude) as NSNumber
        weatherData.latitude = (geoData.latitude) as NSNumber
        
        super.saveContext()
    }
    
    func deletaAllData() {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GeoModelCD")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        try! context.execute(batchDeleteRequest)
    }
}
