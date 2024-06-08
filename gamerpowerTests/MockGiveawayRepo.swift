//
//  MockGiveawayRepo.swift
//  gamerpowerTests
//
//  Created by Amr Adel on 08/06/2024.
//

import Foundation
import Combine
@testable import gamerpower
class MockGiveawayRepo: GiveawayRepoContract {
    var allGiveawaysResult: AnyPublisher<[Giveaway], Error>
    var platformGiveawaysResult: AnyPublisher<[Giveaway], Error>
    var platformsResult: [String] = ["All", "PC", "PS4", "Xbox"]
    
    init() {
        let giveaways = [Giveaway(id: 1, title: "Test Game", description: "Test Description", platforms: "PC, PS4")]
        allGiveawaysResult = Just(giveaways)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let platformGiveaways = [Giveaway(id: 2, title: "Platform Game", description: "Platform Description", platforms: "Xbox")]
        platformGiveawaysResult = Just(platformGiveaways)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getAllGiveaways() -> AnyPublisher<[Giveaway], Error> {
        return allGiveawaysResult
    }
    
    func getGiveaways(for platform: String) -> AnyPublisher<[Giveaway], Error> {
        return platformGiveawaysResult
    }
    
    func getPlatforms() -> [String] {
        return platformsResult
    }
}
