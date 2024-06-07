//
//  GiveawayDetailView.swift
//  gamerpower
//
//  Created by Amr Adel on 08/06/2024.
//

import SwiftUI

struct GiveawayDetailView: View {
    @Environment(\.presentationMode) var presentationMode
        @ObservedObject var viewModel: GiveawayViewModel
        @State var giveaway: Giveaway
        
        var body: some View {
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        AsyncImage(url: URL(string: giveaway.image ?? "")) { phase in
                            switch phase {
                            case .empty:
                                Color.gray.opacity(0.3)
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Color.red
                            @unknown default:
                                Color.gray.opacity(0.3)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                        .clipped()
                        
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                toggleLove()
                            }) {
                                Image(systemName: giveaway.isLoved ? "heart.fill" : "heart")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                            .padding(.trailing)
                        }
                        .padding(.top, 30)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(giveaway.title ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text(giveaway.description ?? "")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
        
        private func toggleLove() {
            if let index = viewModel.allGiveaways.firstIndex(where: { $0.id == giveaway.id }) {
                viewModel.allGiveaways[index].isLoved.toggle()
                giveaway.isLoved.toggle()
            }
        }
    
}

#Preview {
    GiveawayDetailView(viewModel: GiveawayViewModel(), giveaway: Giveaway())
}
