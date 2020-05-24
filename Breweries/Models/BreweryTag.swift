//
//  BreweryTag.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

enum BreweryTag: String, Decodable {
    case dogFriendly = "dog-friendly"
    case patio
    case foodService = "food-service"
    case foodTruck = "food-truck"
    case tours
}
