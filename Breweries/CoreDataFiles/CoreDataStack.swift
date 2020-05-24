//
//  CoreDataStack.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    private let moduleName = "Breweries"

    func save() {
        guard mainManagedObjectContext.hasChanges || privateManagedObjectContex.hasChanges else {
            return
        }
       
       privateManagedObjectContex.perform { [weak self] in
            do {
                try self?.privateManagedObjectContex.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
           self?.mainManagedObjectContext.performAndWait { [weak self] in
               do {
                   try self?.mainManagedObjectContext.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
        }
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: moduleName)
        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = false
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        var modelURL = Bundle.main.url(forResource: moduleName, withExtension: "momd")
        modelURL?.appendPathComponent("Breweries.mom")
        return NSManagedObjectModel(contentsOf: modelURL!)!
    }()

    private lazy var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let persistentStoreURL = applicationDocumentsDirectory.appendingPathComponent("\(moduleName).sqlite")
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: [NSMigratePersistentStoresAutomaticallyOption : true,
                                                                        NSInferMappingModelAutomaticallyOption : true])
        } catch {
            fatalError("PersistanceStore error \(error)")
        }
        return persistentStoreCoordinator
    }()

   // for fetch
    lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjContext
    }()

   // for save
    lazy var privateManagedObjectContex: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = mainManagedObjectContext
        return moc
    }()
}
