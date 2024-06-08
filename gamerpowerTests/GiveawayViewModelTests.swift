//
//  GiveawayViewModelTests.swift
//  gamerpowerTests
//
//  Created by Amr Adel on 08/06/2024.
//

import Foundation
import XCTest
import Combine
@testable import gamerpower

class GiveawayViewModelTests: XCTestCase {
    var mockGiveawayRepo: MockGiveawayRepo!
    var viewModel: GiveawayViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockGiveawayRepo = MockGiveawayRepo()
        viewModel = GiveawayViewModel(giveawayRepo: mockGiveawayRepo)
        cancellables = []
    }
    
    override func tearDown() {
        mockGiveawayRepo = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchAllGiveaways() {
        let expectation = XCTestExpectation(description: "fetch all giveaways")
        
        viewModel.$allGiveaways
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.count, 1)
                XCTAssertEqual(value.first?.title, "Test Game")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchAllGiveaways()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchPlatformGiveaways() {
        let expectation = XCTestExpectation(description: "fetch platform giveaways")
        
        viewModel.$allGiveaways
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.count, 1)
                XCTAssertEqual(value.first?.title, "Platform Game")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchPlatformGiveaways(platform: "Xbox")
        
        wait(for: [expectation], timeout: 1.0)
    }
}
