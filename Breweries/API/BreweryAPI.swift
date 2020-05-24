//
//  BreweryAPI.swift
//  Breweries
//
//  Created by Taras Chernysh on 15.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import Moya

enum BreweryAPI {
    case list(LimitOffset)
    case searchNews(LimitOffset, BreweryName)
}

extension BreweryAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .list, .searchNews:
            return URL(string: "https://api.openbrewerydb.org")!
        }
    }
    
    var path: String {
        switch self {
        case .list, .searchNews:
            return "/breweries"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list, .searchNews:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .list(let pagination):
            return .requestParameters(parameters: ["page": pagination.page,
                                                   "per_page": pagination.limit],
                                      encoding: URLEncoding.default)
        case .searchNews(let pagination, let brewery):
            return .requestParameters(parameters: ["by_name": brewery.name,
                                                   "page": pagination.page,
                                                   "per_page": pagination.limit],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
