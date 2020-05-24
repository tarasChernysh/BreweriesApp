//
//  Coordinate.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation

protocol Coordinate: Decodable {
    var longitude: Double { get set }
    var latitude: Double { get set }
}

struct CoordinateImpl: Coordinate {
    var longitude: Double
    var latitude: Double
}

final class CoordinateFactory {
    static func makeCoordinate(longitude: Double, latitude: Double) -> Coordinate {
        return CoordinateImpl(longitude: longitude, latitude: latitude)
    }
}
