//
//  PokedexService.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import Foundation
import Combine

class PokedexService: PokedexServiceType {
    private var cancellables: Set<AnyCancellable> = .init()
    var pokemonListPublisher: CurrentValueSubject<[Pokemon], Never> = .init([])
    private var nextUrl: String? = nil
    
    init() {
        fetchFirstPokedexResponse()
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] response in
                self?.makePokemonListUseResponse(response)
            }.store(in: &cancellables)
    }
    
    func fetchFirstPokedexResponse() -> AnyPublisher<PokedexResponse, any Error> {
        let url = "https://pokeapi.co/api/v2/pokemon/"
        return httpRequestPublisher(for: url, decodeType: PokedexResponse.self).eraseToAnyPublisher()
    }
    
    func fetchNextPokedexResponse() {
        guard let nextUrl = nextUrl else {
            return
        }
        
        httpRequestPublisher(for: nextUrl, decodeType: PokedexResponse.self)
            .eraseToAnyPublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] response in
                self?.makePokemonListUseResponse(response)
            }.store(in: &cancellables)
    }
    
    private func fetchPokemon(result: PokedexResponse.PokedexResult) -> AnyPublisher<Pokemon, Error> {
        return httpRequestPublisher(for: result.url, decodeType: Pokemon.self).eraseToAnyPublisher()
    }
    
    private func makePokemonListUseResponse(_ response: PokedexResponse) {
        // 다음 페이지 url 저장
        self.nextUrl = response.next
        
        response.results.forEach { result in
            self.fetchPokemon(result: result)
                .flatMap { [weak self] pokemon -> AnyPublisher<Pokemon, Never> in
                    guard let self = self else { return Just(pokemon).eraseToAnyPublisher() }
                    
                    return self.fetchPokemonSpecies(id: pokemon.id)
                        .map { species -> Pokemon in
                            var modifiedPokemon = pokemon
                            modifiedPokemon.koreanName = species.name
                            modifiedPokemon.koreanDescription = species.flavorText
                            return modifiedPokemon
                        }
                        .replaceError(with: pokemon)
                        .eraseToAnyPublisher()
                }
                .sink { _ in }
            receiveValue: { [weak self] pokemon in
                guard let self = self else { return }
                self.pokemonListPublisher.value.append(pokemon)
                self.pokemonListPublisher.value.sort(by: { $0.id < $1.id })
                
                print("✅ Saving \(self.pokemonListPublisher.value.count) Pokémon to UserDefaults")
                PokeMonWidgetManager.shared.savePokemonList(self.pokemonListPublisher.value)
                print("🟢 fetchPokemonList() after saving: \(PokeMonWidgetManager.shared.fetchPokemonList().count) Pokémon")
            }.store(in: &self.cancellables)
        }
    }
    
    // MARK: - 한국어 서비스
    func fetchPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpecies, any Error> {
        let url = "https://pokeapi.co/api/v2/pokemon-species/\(id)"
        
        return httpRequestPublisher(for: url, decodeType: PokemonSpeciesResponse.self)
            .tryMap { response in
                guard let pokemonSpecies = response.extractKoreanInfo() else {
                    throw URLError(.badServerResponse)
                }
                return pokemonSpecies
            }.eraseToAnyPublisher()
    }
}
