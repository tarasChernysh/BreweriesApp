//
//  Address.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

protocol Address: Decodable {
    var street: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var postalCode: String? { get set }
    var country: String? { get set }
}

struct AddressImpl: Address {
    var street: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var country: String?
}



final class AddressFactory {
    static func makeAddress(street: String?, city: String?, state: String?, postalCode: String? = nil, country: String?) -> Address {
        return AddressImpl(street: street, city: city, state: state, postalCode: postalCode, country: country)
    }
}
