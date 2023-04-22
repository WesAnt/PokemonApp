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
    let forms: [FormsInfo]
    let sprites: PokemonSprites
    let weight: Int
}

struct FormsInfo: Codable {
    let name: String
}
struct PokemonSprites: Codable {
    var front_default: String?
}
