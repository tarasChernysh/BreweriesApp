//
//  BreweryViewModel.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift

class BreweryViewModel: UseCasesConsumer {
    typealias UseCases = HasBreweryUseCase & HasDatabaseUseCase
    enum State {
        case search
        case list
    }
    
    lazy var dataSource = BreweryDataSource(viewModel: self, useCases: useCases)
    
    var breweryName: BreweryName?
    var state: State = .list
    let isFetchedTotalResults = MutableProperty(false)
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }
}

// MARK:- Factory

class BreweryViewModelFactory {
    static func makeBreweryViewModel(useCases: UseCases) -> BreweryViewModel {
        return BreweryViewModel(useCases: useCases)
    }
}

