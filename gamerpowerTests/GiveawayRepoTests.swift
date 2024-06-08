//
//  GiveawayRepoTests.swift
//  gamerpowerTests
//
//  Created by Amr Adel on 08/06/2024.
//

import Foundation
import XCTest
import Combine
@testable import gamerpower

class MockNetworkService: NetworkServiceContract {
    var result: AnyPublisher<[Giveaway], Error>!

    func request<T>(_ target: API, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return result as! AnyPublisher<T, Error>
    }
}

class GiveawayRepoTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var giveawayRepo: GiveawayRepo!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        giveawayRepo = GiveawayRepo(networkService: mockNetworkService)
        cancellables = []
    }

    override func tearDown() {
        mockNetworkService = nil
        giveawayRepo = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetAllGiveaways() {
        let giveaways = [Giveaway(id: 1, title: "Test Game", description: "Test Description", platforms: "PC, PS4")]
        mockNetworkService.result = Just(giveaways)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "fetch all giveaways")
        var result: [Giveaway]?

        giveawayRepo.getAllGiveaways()
            .sink(receiveCompletion: { _ in }, receiveValue: { giveaways in
                result = giveaways
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?.first?.title, "Test Game")
    }

    func testExtractPlatforms() {
        let giveaways = [
            Giveaway(id: 1, title: "Test Game", description: "Test Description", platforms: "PC, PS4"),
            Giveaway(id: 2, title: "Another Game", description: "Another Description", platforms: "Xbox, PC")
        ]
        giveawayRepo.extractPlatforms(from: giveaways)
        let platforms = giveawayRepo.getPlatforms()

        XCTAssertEqual(platforms.count, 4)
        XCTAssertEqual(platforms, ["All", "PC", "PS4", "Xbox"])
    }
}
