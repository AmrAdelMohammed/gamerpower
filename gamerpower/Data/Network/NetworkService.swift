//
//  NetworkService.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import Foundation
import Combine
import Moya

class NetworkService {
    private let provider: MoyaProvider<API>

    init(provider: MoyaProvider<API> = MoyaProvider<API>()) {
        self.provider = provider
    }

    func request<T: Decodable>(_ target: API, type: T.Type) -> AnyPublisher<T, Error> {
        return Future<T, Error> { [weak self] promise in
            self?.provider.request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let decodedData = try JSONDecoder().decode(T.self, from: filteredResponse.data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
