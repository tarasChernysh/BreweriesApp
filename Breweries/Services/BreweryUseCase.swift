//
//  BreweryUseCase.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol BreweryUseCase {
    func fetchListOfBreweries(_ pagination: LimitOffset) -> SignalProducer<[BreweryModel], AppError>
    func fetchSearchListOfBreweries(_ pagination: LimitOffset, name: BreweryName) -> SignalProducer<[BreweryModel], AppError>
}
