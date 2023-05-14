//
//  WeatherData+CoreDataProperties.swift
//  
//
//  Created by G G on 14.05.2023.
//
//

import Foundation
import CoreData

public class WeatherData: NSManagedObject {}

extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var list: NSObject?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var latitude: NSNumber?
}
