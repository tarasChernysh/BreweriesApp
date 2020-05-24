//
//  FRCMakeable.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit
import CoreData

protocol FRCMakeable {}

// MARK: UIViewController

extension FRCMakeable where Self: UIViewController {
    func setupFetchedResultsController<T: NSManagedObject>(with fetchReguest: NSFetchRequest<T>, in context: NSManagedObjectContext) -> NSFetchedResultsController<T> {
        fetchReguest.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: #keyPath(BreweryCD.createDate), ascending: true)
        fetchReguest.sortDescriptors = [sortDescriptor]
        let fetchResultController: NSFetchedResultsController<T> = NSFetchedResultsController(fetchRequest: fetchReguest,
                                                                                              managedObjectContext: context,
                                                                                              sectionNameKeyPath: nil,
                                                                                              cacheName: "testCacheName")
        do {
            try fetchResultController.performFetch()
        } catch let error as NSError {
            print("Error fetch FRC: \(error) & \(error.userInfo)")
        }
        return fetchResultController
    }
}
