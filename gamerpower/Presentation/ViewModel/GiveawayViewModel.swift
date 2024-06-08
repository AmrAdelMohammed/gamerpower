//
//  GiveawayViewModel.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import Foundation
import Combine
import SwiftUI

class GiveawayViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let giveawayRepo: GiveawayRepoContract

    @Published var allGiveaways: [Giveaway] = []
    @Published var errorMessage: String?
    @Published var epicGamesGiveaways: [Giveaway] = []
    @Published var platforms: [String] = []

    init(giveawayRepo: GiveawayRepoContract = GiveawayRepo()) {
        self.giveawayRepo = giveawayRepo
        fetchAllGiveaways()
        fetchEpicGamesGiveaways()
    }

    func fetchAllGiveaways() {
        giveawayRepo.getAllGiveaways()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { giveaways in
                self.allGiveaways = giveaways
                self.extractPlatforms(from: giveaways)
            })
            .store(in: &cancellables)
    }

    func fetchPlatformGiveaways(platform: String) {
        let realPlatform = platform.lowercased().replacingOccurrences(of: " ", with: "-")
        giveawayRepo.getGiveaways(for: realPlatform)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { giveaways in
                self.allGiveaways = giveaways
            })
            .store(in: &cancellables)
    }
    
    func fetchEpicGamesGiveaways() {
        giveawayRepo.getGiveaways(for: "epic-games-store")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { giveaways in
                self.epicGamesGiveaways = giveaways
            })
            .store(in: &cancellables)
    }

    private func extractPlatforms(from giveaways: [Giveaway]) {
        var platformSet: Set<String> = ["All"]
        for giveaway in giveaways {
            platformSet.formUnion(giveaway.platformList)
        }
        self.platforms = Array(platformSet).sorted()
    }
    
    func toggleFav(giveaway: Giveaway){
        if let index = allGiveaways.firstIndex(where: { $0.id == giveaway.id }) {
            allGiveaways[index].isLoved.toggle()
        }
    }
}
