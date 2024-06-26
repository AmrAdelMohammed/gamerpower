//
//  GiveawaysView+Properties.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import SwiftUI

extension GiveawaysGamesView {
    
    var header: some View{
        HStack{
            VStack(alignment: .leading){
                Text("👋")
                Text("Hello, Mohamed").font(.footnote)
            }
            Spacer()
            Image(systemName: "person")
        }.padding(.horizontal)
    }
    var tagView: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8){
                ForEach(viewModel.platforms, id: \.self) { platform in
                    Text(platform)
                        .foregroundColor(selectedPlatform == platform ? Color.black : Color.gray)
                        .onTapGesture {
                            selectedPlatform = platform
                            if selectedPlatform == "All" {
                                viewModel.fetchAllGiveaways()
                            } else {
                                viewModel.fetchPlatformGiveaways(platform: selectedPlatform)
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    var gamesView: some View{
        VStack {
                ForEach($viewModel.allGiveaways) { $giveaway in
                    NavigationLink(destination: GiveawayDetailView(giveaway: giveaway, onLove: {viewModel.toggleFav(giveaway: giveaway)})) {
                                            GiveawayRow(giveaway: giveaway, isLoved: giveaway.isLoved, onLove: {
                                                viewModel.toggleFav(giveaway: giveaway)
                                            })
                                        }
                }
            
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)").foregroundColor(.red)
            }
        }
        
    }
    
    
    var adsView: some View {
            AdsCarouselView(giveaways: viewModel.epicGamesGiveaways)
                .frame(height: 200)
                .padding(.vertical)
    }
}
