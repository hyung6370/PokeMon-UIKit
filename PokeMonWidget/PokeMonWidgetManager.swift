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
    
//    func fetchPokemonList() -> [Pokemon] {
//        guard let data = userDefaults?.data(forKey: pokemonKey),
//              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: data) else {
//            return []
//        }
//        return pokemonList
//    }
    
    func fetchPokemonList() -> [Pokemon] {
        guard let data = userDefaults?.data(forKey: pokemonKey) else {
            print("❌ fetchPokemonList: 저장된 포켓몬 데이터가 없습니다.")
            return []
        }
        
        do {
            let pokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
            print("✅ fetchPokemonList: 불러온 포켓몬 리스트 \(pokemonList.count)개")
            return pokemonList
        } catch {
            print("❌ fetchPokemonList: 데이터 디코딩 실패 - \(error)")
            return []
        }
    }
    
    func fetchRandomPokemon() -> Pokemon? {
        let pokemonList = fetchPokemonList()
        print("🔍 fetchRandomPokemon: 포켓몬 개수 = \(pokemonList.count)")
        return pokemonList.randomElement()
    }
}
