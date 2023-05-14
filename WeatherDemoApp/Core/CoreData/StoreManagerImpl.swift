//
//  StoreManager.swift
//  WeatherDemoApp
//
//  Created by G G on 14.05.2023.
//

import Foundation
import CoreData
import UIKit

class StoreManager {
    
    static var shared = StoreManager()
    
    private init() { }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private lazy var context: NSManagedObjectContext = {
        appDelegate.persistentContainer.viewContext
    }()
    
    func saveData(geoData: GeoModelDomain) {
        deletaAllData()
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: context) else { return }
        let weatherData = WeatherData(entity: entity, insertInto: context)
        weatherData.city = geoData.name
        weatherData.country = geoData.country
        weatherData.longitude = (geoData.longitude) as NSNumber
        weatherData.latitude = (geoData.latitude) as NSNumber
        
        appDelegate.saveContext()
    }
    
    func fetchData() -> [WeatherData] {
        let fetchRequest: NSFetchRequest<WeatherData> = WeatherData.fetchRequest()
        guard let objects = try? context.fetch(fetchRequest) else { return [] }
        
        return objects
    }
    
    func updateData(geoData: GeoModelDomain) {
        let weatherData = WeatherData(context: context)
        weatherData.city = geoData.name
        weatherData.country = geoData.country
        weatherData.longitude = (geoData.longitude) as NSNumber
        weatherData.latitude = (geoData.latitude) as NSNumber
        
        appDelegate.saveContext()
    }
    
    func deletaAllData() {
        let deleteRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: deleteRequest)
        try! context.execute(batchDeleteRequest)
    }
}
