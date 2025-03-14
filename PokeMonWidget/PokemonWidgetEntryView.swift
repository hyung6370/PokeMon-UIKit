//
//  PokemonWidgetEntryView.swift
//  PokemonWidgetExtension
//
//  Created by Hyungjun KIM on 2/27/25.
//

import SwiftUI

struct PokemonWidgetEntryView: View {
    var entry: PokemonProvider.Entry
    
    var body: some View {
        if let pokemon = entry.pokemon {
            Link(destination: entry.deepLinkURL ?? URL(string: "pokemonapp://")!) {
                VStack {
                    if let cachedImage = PokeMonWidgetManager.shared.getCachedImage(for: pokemon.imageUrl) {
                        Image(uiImage: cachedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                    }

                    Text(pokemon.koreanName ?? "")
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                    
                    Text("#\(pokemon.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .widgetBackground(ThemeColor.typeColorSwiftUI(type: pokemon.pokemonTypes.first ?? .normal))
            }
        } else {
            Text("포켓몬 정보를 불러오는 중...")
        }
    }
}
