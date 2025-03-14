//
//  DetailViewModel.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/19/25.
//

import UIKit
import Combine

final class DetailViewModel {
    private let pokemon: Pokemon
    private let service: PokedexService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var koreanName: String = ""
    @Published var koreanDescription: String = ""
    
    init(pokemon: Pokemon, service: PokedexService = PokedexService()) {
        self.pokemon = pokemon
        self.service = service
        fetchPokemonSpecies()
    }
    
    private func fetchPokemonSpecies() {
        service.fetchPokemonSpecies(id: pokemon.id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching Pokemon species: (DetailVM)", error)
                    self.koreanName = self.pokemon.name
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] species in
                self?.koreanName = species.name
                self?.koreanDescription = species.flavorText
            }).store(in: &cancellables)
    }
    
    var imageURL: String {
        return pokemon.imageUrl
    }
    
    var name: String {
        return pokemon.name
    }
    
    var firstTypeName: String? {
        return pokemon.pokemonTypes.first?.rawValue
    }
    
    var secondTypeName: String? {
        if pokemon.pokemonTypes.count > 1 {
            return pokemon.pokemonTypes[1].rawValue
        }
        return nil
    }
    
    var firstTypeColor: UIColor? {
        guard let firstTypeName = firstTypeName,
              let type = PokemonType(rawValue: firstTypeName) else { return nil }
        
        return ThemeColor.typeColor(type: type)
    }
    
    var secondTypeColor: UIColor? {
        guard let secondTypeName = secondTypeName,
              let type = PokemonType(rawValue: secondTypeName) else { return nil }
        
        return ThemeColor.typeColor(type: type)
    }
    
    var tag: String {
        return pokemon.tag
    }
    
    var weightText: NSMutableAttributedString {
        return makeMutableAttributedString(firstText: "\(pokemon.height)KG", secondText: "Weight")
    }
    
    var heightText: NSMutableAttributedString {
        return makeMutableAttributedString(firstText: "\(Double(pokemon.height)/10.0)M", secondText: "Height")
    }
    
    var hp: Int {
        return pokemon.statValue(for: .hp)
    }
    
    var attack: Int {
        return pokemon.statValue(for: .attack)
    }
    
    var defense: Int {
        return pokemon.statValue(for: .defense)
    }
    
    var speed: Int {
        return pokemon.statValue(for: .speed)
    }
    
    private func makeMutableAttributedString(firstText: String, secondText: String) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(
            string: "\(firstText)\n\n",
            attributes: [
                .font: ThemeFont.bold(ofSize: 16),
                .foregroundColor: UIColor.black
            ]
        )
        
        attrText.append(NSAttributedString(
            string: secondText,
            attributes: [
                .font: ThemeFont.regular(ofSize: 13),
                .foregroundColor: UIColor.darkGray
            ]
        ))
        
        return attrText
    }
}
