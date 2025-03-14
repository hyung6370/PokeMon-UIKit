//
//  PokemonWidget.swift
//  PokemonWidget
//
//  Created by Hyungjun KIM on 2/26/25.
//

import WidgetKit
import SwiftUI

struct PokemonEntry: TimelineEntry {
    let date: Date
    let pokemon: Pokemon?
    
    var deepLinkURL: URL? {
        guard let pokemon = pokemon else { return nil }
        return URL(string: "pokemonapp://detail?id=\(pokemon.id)")
    }
}

struct PokemonProvider: TimelineProvider {
    func placeholder(in context: Context) -> PokemonEntry {
        PokemonEntry(date: Date(), pokemon: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PokemonEntry) -> Void) {
        let randomPokemon = PokeMonWidgetManager.shared.fetchRandomPokemon()
        completion(PokemonEntry(date: Date(), pokemon: randomPokemon))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PokemonEntry>) -> Void) {
        let randomPokemon = PokeMonWidgetManager.shared.fetchRandomPokemon()
        let timeline = Timeline(entries: [PokemonEntry(date: Date(), pokemon: randomPokemon)], policy: .after(Date().addingTimeInterval(3600)))
        completion(timeline)
    }
}

struct PokemonWidget: Widget {
    let kind: String = "PokemonWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PokemonProvider()) { entry in
            PokemonWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("랜덤 포켓몬")
        .description("매시간 랜덤 포켓몬을 보여줍니다!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
