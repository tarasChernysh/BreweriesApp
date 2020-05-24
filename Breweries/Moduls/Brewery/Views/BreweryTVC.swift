//
//  BreweryTVC.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit

protocol BreweryTVCDelegate: AnyObject {
    func breweryTVCDidTapWebSiteLink(_ cell: BreweryTVC)
    func breweryTVCDidTapShowOnMap(_ cell: BreweryTVC)
}

class BreweryTVC: UITableViewCell {
    enum C {
        static let buttonCornerRadius: CGFloat = 10
        static let viewCornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 1
    }
    
    // MARK: - BreweryTVCDelegate
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var webSiteContainerView: UIView!
    @IBOutlet weak var webSiteTitleLabel: UILabel!
    @IBOutlet weak var webSiteValueLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var showOnMapButton: UIButton!
    
    weak var delegate: BreweryTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    @IBAction func didTapWebSiteLink(_ sender: UIButton) {
        delegate?.breweryTVCDidTapWebSiteLink(self)
    }
    
    @IBAction func didTapShowOnMap(_ sender: UIButton) {
        delegate?.breweryTVCDidTapShowOnMap(self)
    }
    
    func configure(with brewery: BreweryModel) {
        nameLabel.text = brewery.name
        phoneLabel.text = R.string.localizable.phone(brewery.phone ?? "")
        countryLabel.text = R.string.localizable.country(brewery.address?.country ?? "")
        cityLabel.text = R.string.localizable.city(brewery.address?.city ?? "")
        stateLabel.text = R.string.localizable.state(brewery.address?.state ?? "")
        streetLabel.text = R.string.localizable.street(brewery.address?.street ?? "")
        webSiteValueLabel.text = brewery.websiteLink
        webSiteTitleLabel.text = R.string.localizable.web()
        showOnMapButton.setTitle(R.string.localizable.breweryVCShowOnMap(), for: .normal)
        setupVisibleElementsAccordingTo(brewery: brewery)
    }
    
    private func setupVisibleElementsAccordingTo(brewery: BreweryModel) {
        nameLabel.isHidden = brewery.name.isNilOrEmpty
        webSiteContainerView.isHidden = brewery.websiteLink.isNilOrEmpty
        phoneLabel.isHidden = brewery.phone.isNilOrEmpty
        
        webSiteTitleLabel.isHidden = brewery.websiteLink.isNilOrEmpty
   
        let value = brewery.coordinate?.longitude == 1 ? true : false
        showOnMapButton.isHidden = value
        guard let address = brewery.address else {
            streetLabel.isHidden = false
            cityLabel.isHidden = false
            countryLabel.isHidden = false
            stateLabel.isHidden = false
            return
        }
        streetLabel.isHidden = address.street.isNilOrEmpty
        cityLabel.isHidden = address.city.isNilOrEmpty
        countryLabel.isHidden = address.country.isNilOrEmpty
        stateLabel.isHidden = address.state.isNilOrEmpty
        
    }
    
    private func setupLayout() {
        containerView.layer.cornerRadius = C.viewCornerRadius
        containerView.layer.borderColor = R.color.green()!.cgColor
        containerView.layer.borderWidth = C.lineWidth
        showOnMapButton.layer.cornerRadius = C.buttonCornerRadius
    }
}
