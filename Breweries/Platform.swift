//
//  Platform.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

final class Platform: NSObject, UseCasesProvider {
    // MARK: - UseCases
    
    var breweries: BreweryUseCase
    var database: DatabaseUseCases
    
    override init() {
        self.breweries = BreweryService()
        self.database = DatabaseService()
        super.init()
    }
}
