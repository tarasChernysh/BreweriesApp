//
// BreweryCoordinator.swift
// Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright (c) 2020 Taras Chernysh All rights reserved.
//

import UIKit
import SafariServices

final class BreweryCoordinator: Coordinator {
    let useCases: UseCasesProvider
    private let window: UIWindow?
    private lazy var breweryFactory = BreweryViewControllerFactory(coordinator: self)
    private lazy var breweryMapFactory = BreweryMapViewControllerDelegateFactory(coordinator: self)
    
    // MARK: - Init
    
    init(window: UIWindow?, useCases: UseCasesProvider) {
        self.window = window
        self.useCases = useCases
    }
    
    func start() {
        let breweryVC = breweryFactory.makeBreweryViewController(useCases: useCases, delegate: self)
        let navVC = BaseNavigationViewControllerFactory.makeBaseNavigationViewController(withRoot: breweryVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

// MARK: - BreweryViewControllerDelegate

extension BreweryCoordinator: BreweryViewControllerDelegate {
    func breweryViewControllerDidTapWebSiteLink(_ vc: BreweryViewController, brewery: BreweryModel?) {
        guard let path = brewery?.websiteLink, let url = URL(string: path)  else { return }
        let safaryVC = SFSafariViewController(url: url)
        vc.present(safaryVC, animated: true)
    }
    
    func breweryViewControllerShowOnMap(_ vc: BreweryViewController, brewery: BreweryModel?) {
        let breweryMapVC = breweryMapFactory.breweryMapViewControllerDelegate(delegate: self, brewery: brewery)
        vc.present(breweryMapVC, animated: true)
    }
}

// MARK: - BreweryViewControllerDelegate

extension BreweryCoordinator: BreweryMapViewControllerDelegate {
    func breweryMapViewControllerDidTapClose(_ vc: BreweryMapViewController) {
        vc.dismiss(animated: true)
    }
}
