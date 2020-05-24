//
//  AppCoordinator.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift

final class AppCoordinator {
    enum Flow {
        case brewery
    }
    
    // MARK: - Properties

    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)

    private let useCases: UseCasesProvider
    private let flow: Flow
    private let (lifetime, token) = Lifetime.make()

    // MARK: - Setup

    init(useCases: UseCasesProvider, flow: Flow) {
        self.useCases = useCases
        self.flow = flow
        switch flow {
        case .brewery:
            let coordinator = BreweryCoordinator(window: window, useCases: useCases)
            coordinator.start()
        }
    }
    
    
    
}
