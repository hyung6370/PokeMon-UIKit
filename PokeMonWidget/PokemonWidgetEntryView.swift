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
        ZStack {
            if let pokemon = entry.pokemon {
                VStack {
                    AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 80, height: 80)
                    
                    Text(pokemon.koreanName ?? "")
                        .font(.headline)
                        .bold()
                        .lineLimit(1)
                    
                    Text("#\(pokemon.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .widgetBackground(.white)
                .padding()
            } else {
                Text("포켓몬 정보를 불러오는 중...")
            }
        }
        .padding()
        .widgetBackground(.white)
    }
}

//// MARK: - 미리보기
//#Preview {
//    PokemonWidgetEntryView(entry: PokemonEntry(
//        date: Date(),
//        pokemon: Pokemon(
//            height: 10,
//            id: 25,
//            name: "pikachu",
//            stats: [],
//            weight: 60,
//            koreanName: "피카츄",
//            koreanDescription: "전기를 다룰 수 있는 귀여운 포켓몬",
//            pokemonTypes: [.electric]
//        )
//    ))
//}
