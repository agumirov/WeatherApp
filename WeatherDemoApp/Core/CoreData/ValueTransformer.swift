//
//  ValueTransformer.swift
//  WeatherDemoApp
//
//  Created by G G on 23.05.2023.
//

import Foundation

@objc(WeekModelTransformer)
public final class WeekModelTransformer: ValueTransformer {
    
    override public class func transformedValueClass() -> AnyClass {
        return WeekModelDomain.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override public func transformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [WeekModelDomain] else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
    }
    
    override public func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [WeekModelDomain]
    }
}
