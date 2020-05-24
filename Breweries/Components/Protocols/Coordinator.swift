//
//  Coordinator.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var useCases: UseCasesProvider { get }
    func start()
}
