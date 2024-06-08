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
                        Color(Color.black.opacity(0.4))
                        VStack{
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                        .padding()
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
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                            }
                            .padding(.top, 30)
                            Spacer()
                            HStack{
                                Text(giveaway.title ?? "")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    
                                }) {
                                    Text("Get it")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                                .padding(.trailing)
                            }
                        }
                    }
                    HStack(alignment:.center, spacing: 20){
                        HStack{
                            Spacer()
                            VStack(alignment:.center){
                                Image(systemName: "dollarsign.square.fill").frame(width: 25,height: 25)
                                Text(giveaway.worth ?? "")
                            }
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            VStack(alignment:.center){
                                Image(systemName: "person.2.fill").frame(width: 25,height: 25)
                                Text("\(giveaway.users ?? 0)")
                            }
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            VStack(alignment:.center){
                                Image(systemName: "gamecontroller.fill").frame(width: 25,height: 25)
                                Text(giveaway.type?.rawValue ?? "")
                            }
                            Spacer()
                        }
                    }.padding(.horizontal)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Platforms")
                            .font(.title2)
                            .fontWeight(.bold).multilineTextAlignment(.leading)
                        Text(giveaway.platforms ?? "")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                        Text("Giveaway end date")
                            .font(.title2)
                            .fontWeight(.bold).multilineTextAlignment(.leading)
                        Text(giveaway.endDate ?? "")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold).multilineTextAlignment(.leading)
                        Text(giveaway.description ?? "")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                        
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
                viewModel.objectWillChange.send()
                giveaway.isLoved.toggle()
            }
        }
    
}

#Preview {
    GiveawayDetailView(viewModel: GiveawayViewModel(), giveaway: Giveaway())
}
