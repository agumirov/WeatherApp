//
//  WeekModelCD+CoreDataClass.swift
//  
//
//  Created by G G on 23.05.2023.
//
//

import Foundation
import CoreData


public class WeekModelCD: NSManagedObject {}

extension WeekModelCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeekModelCD> {
        return NSFetchRequest<WeekModelCD>(entityName: "WeekModelCD")
    }

    @NSManaged public var day: Double
    @NSManaged public var temperature: String?
    @NSManaged public var weatherImage: String?
    @NSManaged public var weekDay: String?
}
