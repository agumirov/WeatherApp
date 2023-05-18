//
//  WeatherData+CoreDataProperties.swift
//  
//
//  Created by G G on 14.05.2023.
//
//

import Foundation
import CoreData

public class GeoModelCD: NSManagedObject {}

extension GeoModelCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeoModelCD> {
        return NSFetchRequest<GeoModelCD>(entityName: "GeoModelCD")
    }

    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var longitude: NSNumber
    @NSManaged public var latitude: NSNumber
}
