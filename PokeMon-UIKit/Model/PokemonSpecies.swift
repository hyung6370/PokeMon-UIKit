//
//  PokemonSpecies.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/20/25.
//

import Foundation

struct PokemonSpecies: Codable {
    let name: String
    let flavorText: String
}

struct PokemonSpeciesResponse: Codable {
    struct Name: Codable {
        let name: String
        let language: Language
    }
    
    struct FlavorTextEntry: Codable {
        let flavor_text: String
        let language: Language
        let version: Version
    }
    
    struct Language: Codable {
        let name: String
    }
    
    struct Version: Codable {
        let name: String
    }
    
    let names: [Name]
    let flavor_text_entries: [FlavorTextEntry]
    
    func extractKoreanInfo() -> PokemonSpecies? {
        guard let koreanName = names.first(where: { $0.language.name == "ko" })?.name,
              let koreanFlavorText = flavor_text_entries.first(where: { $0.language.name == "ko" })?.flavor_text else {
            return nil
        }
        
        return PokemonSpecies(name: koreanName, flavorText: koreanFlavorText)
    }
}
