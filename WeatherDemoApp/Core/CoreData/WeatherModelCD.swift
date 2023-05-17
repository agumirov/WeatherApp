//
//  WeatherData+CoreDataProperties.swift
//  
//
//  Created by G G on 14.05.2023.
//
//

import Foundation
import CoreData

public class WeatherModelCD: NSManagedObject {}

extension WeatherModelCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherModelCD> {
        return NSFetchRequest<WeatherModelCD>(entityName: "WeatherData")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var list: NSObject?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var latitude: NSNumber?
}
