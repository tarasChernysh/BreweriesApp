//
//  UIViewController+Coordinator.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit

private enum UIViewControllerKeys {
    static var coordinator = "coordinator"
}

extension UIViewController {
    static var describing: String {
        return String(describing: self.self)
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        setAssociatedObject(value: coordinator,
                            key: UIViewControllerKeys.coordinator,
                            policy: .retainNonatomic)
    }
}
