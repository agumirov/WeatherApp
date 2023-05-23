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
        return NSFetchRequest<WeatherModelCD>(entityName: "WeatherModelCD")
    }

    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var list: [NSObject]
    @NSManaged public var icon: String
    @NSManaged public var date: Double
    @NSManaged public var temperature: Double
    @NSManaged public var humidity: Double
    @NSManaged public var pressure: Double
    @NSManaged public var windspeed: Double
    @NSManaged public var visibility: Double
}
