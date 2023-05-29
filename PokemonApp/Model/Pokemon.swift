//
//  PokemonResults.swift
//  PokemonApp
//
//  Created by Wesley White on 19/04/2023.
//

import Foundation

struct PokemonList: Codable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable {
    let name: String
    let url: String
}

struct PokemonStats: Codable {
    let name: String
    let weight: Int
    let height: Int
}

struct PokemonSprites: Codable {
    var front_default: String?
}
