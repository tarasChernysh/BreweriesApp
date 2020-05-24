//
//  BreweryService.swift
//  Breweries
//
//  Created by Taras Chernysh on 14.01.2020.
//  Copyright © 2020 Taras Chernysh. All rights reserved.
//

import Foundation
import ReactiveSwift
import Moya

final class BreweryService: BreweryUseCase {
    
    private let provider = MoyaProvider<BreweryAPI>(plugins:[NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    func fetchListOfBreweries(_ pagination: LimitOffset) -> SignalProducer<[BreweryModel], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.list(pagination), completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseBreweries = try decoder.decode([BreweryModelImpl.Response].self, from: response.data)
                        let news = responseBreweries.map { BreweryModelImpl($0) }
                        observer.send(value: news)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                }
            })
        }).observe(on: UIScheduler())
    }
    
    func fetchSearchListOfBreweries(_ pagination: LimitOffset, name: BreweryName) -> SignalProducer<[BreweryModel], AppError> {
        return SignalProducer({ [weak self] observer, lifetime in
            guard let self = self else { return }
            self.provider.request(.searchNews(pagination, name), completion: { result in
                let decoder = JSONDecoder()
                switch result {
                case .success(let response):
                    do {
                        let responseBreweries = try decoder.decode([BreweryModelImpl.Response].self, from: response.data)
                        let news = responseBreweries.map { BreweryModelImpl($0) }
                        observer.send(value: news)
                        observer.sendCompleted()
                    } catch DecodingError.dataCorrupted(let context) {
                        let decodeError = DecodingError.dataCorrupted(context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        let decodeError = DecodingError.keyNotFound(key,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        let decodeError = DecodingError.typeMismatch(type,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        let decodeError = DecodingError.valueNotFound(value,context)
                        observer.send(error: AppError.decodeError(DecodeError(decodeError)))
                    } catch let error {
                        observer.send(error: AppError.decodeError(DecodeError(error)))
                    }
                    
                case .failure(let error):
                    observer.send(error: AppError.networkError(NetworkError(error)))
                }
            })
        }).observe(on: UIScheduler())
    }
    
    
}

enum NetworkError: Error {
    case responseDataNil
    case internetConnection
    case error(Error)
    
    init(_ value: Error) {
        self = .error(value)
    }
    
    var description: String {
        switch self {
        case .responseDataNil:
            return R.string.alert.dataResponseNil()
        case .error(let error):
            return error.localizedDescription
        case .internetConnection:
            return R.string.alert.internetConnectionError()
        }
    }
}

enum DecodeError: Error {
    case error(Error)
    
    init(_ value: Error) {
        self = .error(value)
    }
    
    var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        }
    }
}
