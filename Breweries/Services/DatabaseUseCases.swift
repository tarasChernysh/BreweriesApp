//
//  DatabaseUseCases.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

protocol DatabaseUseCases {
    func save(_ brewery: BreweryModel)
    func saveAfterSearch(_ brewery: BreweryModel, id: Int)
    func isAllowFirstfetch() -> Bool
}
