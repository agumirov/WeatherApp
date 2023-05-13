//
//  DependenciesImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

class DIContainer {
    
    static var standart = DIContainer()
    
    private var dependencies: [String: Weak] = [:]
    
    func register<Dependency>(_ dependency: Dependency) {
        let key = "\(type(of: Dependency.self))"
        let weak = Weak(weakValue: dependency as AnyObject)
        dependencies[key] = weak
    }
    
    func resolve<Dependency>() -> Dependency {
        let key = "\(type(of: Dependency.self))"
        let weak = dependencies[key]
        
        if weak != nil {
            guard let dependency = weak?.weakValue as? Dependency
            else { fatalError("value is nil") }
            return dependency
        } else {
            fatalError("Dependency not found")
        }
    }
}


class Weak {
    
    weak var weakValue: AnyObject?
    
    init(weakValue: AnyObject) {
        self.weakValue = weakValue
    }
}
