//
//  BaseNavigationViewController.swift
//  Breweries
//
//  Created by Taras Chernysh on 18.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit

// MARK:- Factory

class BaseNavigationViewControllerFactory {
    static func makeBaseNavigationViewController(withRoot rootVC: BaseViewController) -> BaseNavigationViewController {
        return BaseNavigationViewController(rootViewController: rootVC)
    }
}


class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        navigationBar.barTintColor = R.color.green()
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
