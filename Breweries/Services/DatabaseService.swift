//
//  DatabaseService.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import CoreData

// MARK:- Factory

protocol BreweryCDFactory {
    func makeBreweryCD(brewery: BreweryModel) -> BreweryCD?
}

class BreweryCDFactoryImpl: BreweryCDFactory {
    @discardableResult
    func makeBreweryCD(brewery: BreweryModel) -> BreweryCD? {
        guard let breweryEntity = NSEntityDescription.entity(forEntityName: BreweryCD.entityName, in: CoreDataStack.shared.privateManagedObjectContex)
            else {
                return nil
        }
        let breweryCD = NSManagedObject(entity: breweryEntity, insertInto: CoreDataStack.shared.privateManagedObjectContex) as? BreweryCD
        
        breweryCD?.name = brewery.name
        breweryCD?.street = brewery.address?.street
        breweryCD?.country = brewery.address?.country
        breweryCD?.city = brewery.address?.city
        breweryCD?.state = brewery.address?.state
        breweryCD?.id = Int64(brewery.id)
        breweryCD?.phone = brewery.phone
        breweryCD?.websiteLink = brewery.websiteLink
        breweryCD?.updatedAt = brewery.updatedAt
        breweryCD?.latitude = brewery.coordinate?.latitude ?? 1
        breweryCD?.longitude = brewery.coordinate?.longitude ?? 1
        breweryCD?.createDate = Date()
        
        return breweryCD
    }
}

final class DatabaseService: DatabaseUseCases {
    
    private let factory = BreweryCDFactoryImpl()
    
    func save(_ brewery: BreweryModel) {
        factory.makeBreweryCD(brewery: brewery)
        CoreDataStack.shared.save()
    }
    
    func saveAfterSearch(_ brewery: BreweryModel, id: Int) {
        let isSavedBrewery = checkSavedBrewery(id: id)
        guard !isSavedBrewery else { return }
        factory.makeBreweryCD(brewery: brewery)
        CoreDataStack.shared.save()
    }
    
    
    func isAllowFirstfetch() -> Bool {
        let request: NSFetchRequest<BreweryCD> = BreweryCD.fetchRequest()
        request.resultType = .countResultType
        do {
            let count = try CoreDataStack.shared
                .mainManagedObjectContext
                .count(for: request)
            return count == 0
        } catch {
            print("error: \(error.localizedDescription)")
            return true
        }
    }
    
    private func checkSavedBrewery(id: Int) -> Bool {
        let request: NSFetchRequest<BreweryCD> = BreweryCD.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        request.propertiesToFetch = [#keyPath(BreweryCD.id)]
        request.resultType = .managedObjectIDResultType
        do {
            guard let result = try CoreDataStack.shared.mainManagedObjectContext.execute(request) as? NSAsynchronousFetchResult<NSFetchRequestResult> else {
                return true
            }
            return result.finalResult?.isEmpty ?? false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    
}
