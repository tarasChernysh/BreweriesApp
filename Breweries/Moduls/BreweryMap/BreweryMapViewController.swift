//
//  ViewController.swift
//  Breweries
//
//  Created by Taras Chernysh on 16.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Factory

final class BreweryMapViewControllerDelegateFactory {
    private(set) weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    func breweryMapViewControllerDelegate(delegate: BreweryMapViewControllerDelegate?, brewery: BreweryModel?) -> BreweryMapViewController {
        let vc = BreweryMapViewController(brewery: brewery)
        vc.delegate = delegate
        coordinator.flatMap { vc.setCoordinator($0) }
        return vc
    }
}

protocol BreweryMapViewControllerDelegate: AnyObject {
    func breweryMapViewControllerDidTapClose(_ vc: BreweryMapViewController)
}


class BreweryMapViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    
    weak var delegate: BreweryMapViewControllerDelegate?
    private let brewery: BreweryModel?

    // MARK: - Life cycle
    
    init(brewery: BreweryModel?) {
        self.brewery = brewery
        super.init(nibName: R.nib.breweryMapViewController.name, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Action
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        delegate?.breweryMapViewControllerDidTapClose(self)
    }
    
    // MARK: - Setup
    
    private func setup() {
        closeButton.setTitle(R.string.localizable.breweryMapVCClose(), for: .normal)
        addAnnotation()
    }
    
    // MARK: - Helper methods
    
    private func addAnnotation() {
        guard let brewery = brewery, let coordinate = brewery.coordinate else { return }
        let breweryPin = MKPointAnnotation()
        breweryPin.title = brewery.name
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude,
        longitude: coordinate.longitude)
        breweryPin.coordinate = center
        mapView.addAnnotation(breweryPin)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
}
