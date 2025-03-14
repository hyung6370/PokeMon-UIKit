//
//  Pokemon.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/17/25.
//

import Foundation

enum StatType: String {
    case hp, attack, defense, speed
}

struct PokedexResponse: Codable {
    let count: Int
    let next: String?
    
    struct PokedexResult: Codable {
        let name: String
        let url: String
    }
    
    let results: [PokedexResult]
}

// MARK: - Pokemon
// Diffable DataSource를 사용하기 위해 Hashable 준수
struct Pokemon: Codable, Hashable {
    let identifier = UUID()
    let height: Int
    let id: Int
    let name: String
    let stats: [Stat]
    private let types: [TypeElement]
    let weight: Int
    
    var koreanName: String?
    var koreanDescription: String?
    
    var pokemonTypes: [PokemonType] {
        return types.map { PokemonType(rawValue: $0.type.name) ?? .normal }
    }
    
    var imageUrl: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
    
    var tag: String {
        return String(format: "%04d", id)
    }
    
    func statValue(for statType: StatType) -> Int {
        return stats.first(where: { $0.stat.name == statType.rawValue })?.baseStat ?? 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct StatClass: Codable {
    let name: String
    let url: String
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: StatClass
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: StatClass
}
