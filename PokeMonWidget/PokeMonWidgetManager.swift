//
//  PokeMonWidgetManager.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/25/25.
//

import Foundation

class PokeMonWidgetManager {
    static let shared = PokeMonWidgetManager()
    private let userDefaults = UserDefaults(suiteName: "group.com.pokemon-uikit.pokemon")
    
    private let pokemonKey = "pokemon_list"
    
    func savePokemonList(_ pokemonList: [Pokemon]) {
        guard let data = try? JSONEncoder().encode(pokemonList) else { return }
        userDefaults?.set(data, forKey: pokemonKey)
    }
    
    func fetchPokemonList() -> [Pokemon] {
        guard let data = userDefaults?.data(forKey: pokemonKey),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: data) else {
            return []
        }
        return pokemonList
    }
    
    func fetchRandomPokemon() -> Pokemon? {
        let pokemonList = fetchPokemonList()
        return pokemonList.randomElement()
    }
}
