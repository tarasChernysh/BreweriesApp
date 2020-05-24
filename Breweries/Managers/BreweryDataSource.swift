//
//  BreweryDataSource.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift

final class BreweryDataSource: UseCasesConsumer {
    typealias UseCases = HasDatabaseUseCase
    
    // MARK: - Properties
    
    let viewModel: BreweryViewModel
    private let (lifetime, token) = Lifetime.make()
    private var filterBreweries: [BreweryModel] = []
    private var currentPage = 1
    var currentPageForSearch = 1
    private let resultsNumber = 10
    let isFetchInProgress = MutableProperty(false)
    let isFetchTotalResults = MutableProperty(false)
    let fetchedError = MutableProperty<AppError>(AppError.defaultError)
    let successFetch = MutableProperty(false)
    var currentCount: Int {
        return filterBreweries.count
    }
    
    func removeAll() {
        filterBreweries.removeAll()
    }
    
    func brewery(at index: Int) -> BreweryModel {
        return filterBreweries[index]
    }
    
    func safatyAccessToBrewery(at index: Int) -> BreweryModel? {
        return filterBreweries.item(at: index)
    }
    
    //MARK: - Initialization
    
    init(viewModel: BreweryViewModel, useCases: UseCases) {
        self.viewModel = viewModel
        self.useCases = useCases
    }
    
    //MARK: - Helper Method
    
    func fetchBreweries() {
        guard !isFetchInProgress.value else { return }
        isFetchInProgress.value = true
        
        viewModel.useCases.breweries.fetchListOfBreweries(LimitOffset(page: currentPage, limit: resultsNumber))
            .take(during: lifetime)
            .startWithResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let someBreweries):
                    self.isFetchInProgress.value = false
                    someBreweries.forEach { item in
                        self.useCases.database.save(item)
                    }
                    self.isFetchTotalResults.value = someBreweries.isEmpty ? true : false
                    self.currentPage += 1
                case .failure(let error):
                    self.isFetchInProgress.value = false
                    self.fetchedError.value = error
                }
        }
    }
   
    func fetchSearchedBreweries(name: BreweryName) {
        guard !isFetchInProgress.value else { return }
        isFetchInProgress.value = true
        
        viewModel.useCases.breweries.fetchSearchListOfBreweries(LimitOffset(page: currentPageForSearch, limit: resultsNumber), name: name)
            .take(during: lifetime)
            .startWithResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let someBreweries):
                    self.isFetchInProgress.value = false
                    someBreweries.forEach { item in
                        self.filterBreweries.append(item)
                    }
                    self.isFetchTotalResults.value = someBreweries.isEmpty ? true : false
                    self.successFetch.value = true
                    self.currentPageForSearch += 1
                case .failure(let error):
                    self.isFetchInProgress.value = false
                    self.fetchedError.value = error
                }
        }
    }
}
