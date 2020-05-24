//
//  UserDefaults+Pagination.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

extension UserDefaults {
    var breweriesTotalResult: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    var availableCountBrewery: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    var currentPage: Int {
        get { return integer(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }
    
    func removeAllData() {
        removeObject(forKey: "breweriesTotalResult")
        removeObject(forKey: "currentPage")
        removeObject(forKey: "availableCountBrewery")
    }
}
