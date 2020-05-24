//
//  BreweryModel+Response.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

extension BreweryModelImpl {
    struct Response: Decodable {
        var id: Int
        var name: String?
        var breweryType: BreweryType?
        var address: Address?
        var coordinate: Coordinate?
        var phone: String?
        var websiteLink: String?
        var updatedAt: String?
        var tagList: [BreweryTag]
        
        private enum MainCodingKey: String, CodingKey {
            case id
            case name
            case breweryType = "brewery_type"
            case phone
            case websiteLink = "website_url"
            case street
            case city
            case state
            case postalCode = "postal_code"
            case country
            case longitude
            case latitude
            case updatedAt = "updated_at"
            case tagList = "tag_list"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: MainCodingKey.self)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            id = try container.decode(Int.self, forKey: .id)
            phone = try container.decodeIfPresent(String.self, forKey: .phone)
            websiteLink = try container.decodeIfPresent(String.self, forKey: .websiteLink)
            updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
            breweryType = try container.decodeIfPresent(BreweryType.self, forKey: .breweryType)
            tagList = try container.decode([BreweryTag].self, forKey: .tagList)
            
            if let longitudeStr = try container.decodeIfPresent(String.self, forKey: .longitude),
                let latitudeStr = try container.decodeIfPresent(String.self, forKey: .latitude),
                let latitude = Double(latitudeStr),
                let longitude = Double(longitudeStr) {
                coordinate = CoordinateImpl(longitude: longitude, latitude: latitude)
            } else {
                coordinate = nil
            }
            
            if let street = try container.decodeIfPresent(String.self, forKey: .street),
                let state = try container.decodeIfPresent(String.self, forKey: .state),
                let country = try container.decodeIfPresent(String.self, forKey: .country),
                let postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode),
                let city = try container.decodeIfPresent(String.self, forKey: .city) {
                address = AddressImpl(street: street, city: city, state: state, postalCode: postalCode, country: country)
            } else {
                address = nil
            }
        }
    }
    
    init(_ response: Response) {
        let updatedAt = DateFormatter.updatedAt(date: response.updatedAt ?? "")
        self.init(id: response.id,
                  name: response.name,
                  breweryType: response.breweryType,
                  address: response.address,
                  coordinate: response.coordinate,
                  phone: response.phone,
                  websiteLink: response.websiteLink,
                  updatedAt: updatedAt,
                  tagList: response.tagList)
    }
}

