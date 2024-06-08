//
//  GiveawayRepo.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import Foundation
import Combine
import Moya

protocol GiveawayRepoContract{
    func getAllGiveaways() -> AnyPublisher<[Giveaway], Error>
    func getGiveaways(for platform: String) -> AnyPublisher<[Giveaway], Error>
    func getPlatforms() -> [String]
}

class GiveawayRepo: GiveawayRepoContract {
    private let networkService: NetworkServiceContract
    private var platforms: [String] = ["All"]

    init(networkService: NetworkServiceContract = NetworkService()) {
        self.networkService = networkService
    }

    func getAllGiveaways() -> AnyPublisher<[Giveaway], Error> {
        return networkService.request(.getGiveaways(platform: nil), type: [Giveaway].self)
            .handleEvents(receiveOutput: { [weak self] giveaways in
                self?.extractPlatforms(from: giveaways)
            })
            .eraseToAnyPublisher()
    }

    func getGiveaways(for platform: String) -> AnyPublisher<[Giveaway], Error> {
        return networkService.request(.getGiveaways(platform: platform), type: [Giveaway].self)
    }

    func getPlatforms() -> [String] {
        return platforms
    }

    private func extractPlatforms(from giveaways: [Giveaway]) {
        var platformSet: Set<String> = ["All"]
        for giveaway in giveaways {
            platformSet.formUnion(giveaway.platformList)
        }
        platforms = Array(platformSet).sorted()
    }
}
