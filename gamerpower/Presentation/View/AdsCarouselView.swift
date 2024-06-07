//
//  AdsCarouselView.swift
//  gamerpower
//
//  Created by Amr Adel on 07/06/2024.
//

import SwiftUI

struct AdsCarouselView: View {
    let giveaways: [Giveaway]
    
    var body: some View {
        GeometryReader { outerGeometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(giveaways) { giveaway in
                        GeometryReader { innerGeometry in
                            ZStack(alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: giveaway.image ?? "")) { phase in
                                    switch phase {
                                    case .empty:
                                        Color.gray.opacity(0.3)
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: outerGeometry.size.width * 0.8, height: 200)
                                            .clipped()
                                    case .failure:
                                        Color.red
                                    @unknown default:
                                        Color.gray.opacity(0.3)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(giveaway.title ?? "")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding([.leading, .trailing, .top], 10)
                                    Spacer()
                                    Text(giveaway.description ?? "")
                                        .font(.subheadline).lineLimit(4)
                                        .foregroundColor(.white)
                                        .padding(10)
                                }
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .rotation3DEffect(
                                .degrees(Double(innerGeometry.frame(in: .global).midX - outerGeometry.size.width / 2) / -20),
                                axis: (x: 0.5, y: 0, z: 0)
                            )
                        }
                        .frame(width: outerGeometry.size.width * 0.8, height: 200)
                    }
                }
                .padding(.horizontal, (outerGeometry.size.width - (outerGeometry.size.width * 0.8)) / 2)
                .animation(.easeInOut, value: giveaways)
            }
        }
    }
}
