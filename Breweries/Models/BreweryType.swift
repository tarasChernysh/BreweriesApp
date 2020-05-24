//
//  BreweryType.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

enum BreweryType: String, Decodable {
    case micro
    case regional
    case brewpub
    case large
    case planning
    case bar
    case contract
    case proprietor
}
