//
//  GiveAwayRow.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import SwiftUI

struct GiveawayRow: View {
    let giveaway: Giveaway
    @State private var isLoved: Bool = false
    let onLove: () -> Void
    init(giveaway: Giveaway, isLoved: Bool,onLove: @escaping () -> Void){
        self.giveaway = giveaway
        self.isLoved = giveaway.isLoved
        self.onLove = onLove
    }
    var body: some View {
        ZStack(alignment: .leading){
            AsyncImage(url: URL(string: giveaway.image ?? "")) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.3)
                case .success(let image):
                    image.resizable()
                        .clipped()
                case .failure:
                    Color.red
                @unknown default:
                    Color.gray.opacity(0.3)
                }
            }
            
            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading){
                        Text(giveaway.title ?? "")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        Text(giveaway.platforms ?? "")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                    }
                    Spacer()
                    Image(systemName:  isLoved ? "heart.fill" : "heart").resizable().frame(width: 25,height: 25)
                        .foregroundColor(.white)
                        .onTapGesture {
                            isLoved.toggle()
                            onLove()
                        }.padding(.trailing)
                    
                }
                Spacer()
                Text(giveaway.description ?? "")
                    .font(.subheadline).lineLimit(4)
                    .foregroundColor(.white)
                    .padding(10)
            }
            .padding(.vertical)
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
        }
        .frame(height: 300)
        .cornerRadius(10)
        .padding([.leading, .trailing, .top], 10)
    }
}

