//
//  BreweryModel.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

// MARK:- Protocol

protocol BreweryModel {
    var id: Int { get set }
    var name: String? { get set }
    var breweryType: BreweryType? { get set }
    var address: Address? { get set }
    var coordinate: Coordinate? { get set }
    var phone: String? { get set }
    var websiteLink: String? { get set }
    var updatedAt: String? { get set }
    var tagList: [BreweryTag] { get set }
}

// MARK:- Implementation

struct BreweryModelImpl: BreweryModel {
    var id: Int
    var name: String?
    var breweryType: BreweryType?
    var address: Address?
    var coordinate: Coordinate?
    var phone: String?
    var websiteLink: String?
    var updatedAt: String?
    var tagList: [BreweryTag]
}

extension BreweryModelImpl {
    init(_ breweryCD: BreweryCD) {
        let address = AddressFactory.makeAddress(street: breweryCD.street,
                                                 city: breweryCD.city,
                                                 state: breweryCD.state,
                                                 country: breweryCD.country)
        let coordinate = CoordinateFactory.makeCoordinate(longitude: breweryCD.longitude,
                                                          latitude: breweryCD.latitude)
        self.init(id: Int(breweryCD.id),
                  name: breweryCD.name,
                  breweryType: nil,
                  address: address,
                  coordinate: coordinate,
                  phone: breweryCD.phone,
                  websiteLink: breweryCD.websiteLink,
                  updatedAt: breweryCD.updatedAt,
                  tagList: [])
    }
}
