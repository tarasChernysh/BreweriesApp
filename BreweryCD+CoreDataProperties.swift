//
//  BreweryCD+CoreDataProperties.swift
//  Breweries
//
//  Created by Taras Chernysh on 17.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//
//

import Foundation
import CoreData


extension BreweryCD {
    static let entityName = "BreweryCD"

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreweryCD> {
        return NSFetchRequest<BreweryCD>(entityName: BreweryCD.entityName)
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var updatedAt: String?
    @NSManaged public var phone: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var websiteLink: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var createDate: Date

}
