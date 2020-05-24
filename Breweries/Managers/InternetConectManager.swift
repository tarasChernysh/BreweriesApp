//
//  InternetConectManager.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

class InternetConnectManager {
    private let networkReachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    init() {
        self.networkReachabilityManager?.startListening()
    }
    
    deinit {
        self.networkReachabilityManager?.stopListening()
    }
    
    var isConnect: Property<Bool> {
        return Property(initial: true, then: checkForReachability())
    }
    
    private func checkForReachability() -> Signal<Bool, Never> {
        return Signal({ [weak self] observer, lifetime in
            guard let self = self else { return }
            guard !lifetime.hasEnded else {
                observer.sendInterrupted()
                return
            }
            
            self.networkReachabilityManager?.listener = { status in
                switch status {
                case .notReachable:
                    observer.send(value: false)
                case .reachable, .unknown:
                     observer.send(value: true)
                }
            }
        })
    }
}

