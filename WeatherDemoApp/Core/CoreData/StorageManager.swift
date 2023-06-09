//
//  StoreManager.swift
//  WeatherDemoApp
//
//  Created by G G on 14.05.2023.
//

import Foundation
import CoreData
import UIKit

class StorageManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherStorage")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createObject<Entity: NSManagedObject>() -> Entity {
        return Entity(context: context)
    }
    
    func fetchObjects<Entity: NSManagedObject>(
        entityType: Entity.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil)
    -> [Entity] {
        let request = Entity.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        do {
            return try context.fetch(request) as! [Entity]
        } catch {
            print("Fetch failed with error: \(error)")
            return []
        }
    }
    
    func deleteObject<Entity: NSManagedObject>(_ object: Entity) {
        context.delete(object)
        saveContext()
    }
}

enum StorageErrors: String, Error {
    case savingFailed = "Saving data failed"
    case fetchingFailed = "Fetching data failed"
}
