//
//  UseCasesProvider.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

protocol HasDatabaseUseCase {
    var database: DatabaseUseCases { get }
}

protocol HasBreweryUseCase {
    var breweries: BreweryUseCase { get }
}

typealias UseCases = HasBreweryUseCase & HasDatabaseUseCase

protocol UseCasesProvider: UseCases {}
