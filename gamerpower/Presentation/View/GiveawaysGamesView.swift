//
//  GiveawaysGamesView.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import SwiftUI

struct GiveawaysGamesView: View {
    @StateObject var viewModel = GiveawayViewModel()
    @State var selectedPlatform = "All"
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    header
                    Text("Expolre\nGames Giveaways").font(.title).fontWeight(.bold).padding(.horizontal)
                    adsView
                    tagView
                    gamesView
                }
            }
        }.onAppear {
           
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    GiveawaysGamesView()
}
