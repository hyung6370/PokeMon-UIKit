//
//  PokeMonWidgetManager.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/25/25.
//

import UIKit

class PokeMonWidgetManager {
    static let shared = PokeMonWidgetManager()
    private let userDefaults = UserDefaults(suiteName: "group.com.pokemon-uikit.pokemon")
    
    private let pokemonKey = "pokemon_list"
    private let imageCacheKey = "pokemon_image_cache"
    
    func savePokemonList(_ pokemonList: [Pokemon]) {
        guard let data = try? JSONEncoder().encode(pokemonList) else {
#if DEBUG
            print("❌ savePokemonList: 포켓몬 리스트 인코딩 실패!")
#endif
            
            return
        }
        userDefaults?.set(data, forKey: pokemonKey)
#if DEBUG
        print("✅ savePokemonList: 포켓몬 \(pokemonList.count)개 저장 완료!")
#endif
        
        cachePokemonImages(pokemonList)
    }
    
    func fetchPokemonList() -> [Pokemon] {
        guard let data = userDefaults?.data(forKey: pokemonKey) else {
#if DEBUG
            print("❌ fetchPokemonList: 저장된 포켓몬 데이터가 없습니다.")
#endif
            return []
        }
        
        do {
            let pokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
#if DEBUG
            print("✅ fetchPokemonList: 불러온 포켓몬 리스트 \(pokemonList.count)개")
#endif
            return pokemonList
        } catch {
#if DEBUG
            print("❌ fetchPokemonList: 데이터 디코딩 실패 - \(error)")
#endif
            return []
        }
    }
    
    func fetchRandomPokemon() -> Pokemon? {
        let pokemonList = fetchPokemonList()
        print("🔍 fetchRandomPokemon: 포켓몬 개수 = \(pokemonList.count)")
        return pokemonList.randomElement()
    }
    
    private func cachePokemonImages(_ pokemonList: [Pokemon]) {
        var imageCache = [String: Data]()
        let dispatchGroup = DispatchGroup()
        
        for pokemon in pokemonList {
            guard let url = URL(string: pokemon.imageUrl) else { continue }
            dispatchGroup.enter()
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let originalImage = UIImage(data: data) {
                    let convertedImage = originalImage.convertIndexedPNGToRGB()
                    if let convertedData = convertedImage.pngData() {
                        imageCache[pokemon.imageUrl] = convertedData
                    }
                } else {
                    print("❌ 이미지 다운로드 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                }
                dispatchGroup.leave()
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.userDefaults?.set(imageCache, forKey: self.imageCacheKey)
        }
    }
    
    func getCachedImage(for url: String) -> UIImage? {
        guard let cache = userDefaults?.dictionary(forKey: imageCacheKey) as? [String: Data],
              let imageData = cache[url] else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
