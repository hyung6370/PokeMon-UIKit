//
//  Pokemon.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/17/25.
//

import Foundation

enum StateType: String {
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
