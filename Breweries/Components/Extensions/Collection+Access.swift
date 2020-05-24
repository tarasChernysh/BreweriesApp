//
//  Collection+Access.swift
//  Breweries
//
//  Created by Taras Chernysh on 18.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import UIKit

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    func item(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
