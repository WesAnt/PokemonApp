//
//  PokemonCollectionViewCellViewModel.swift
//  PokemonApp
//
//  Created by Wesley White on 23/04/2023.
//

import Foundation

struct PokemonCollectionViewCellViewModel {
    private var pokemonNameText: String
    private var pokemonImageUrl: String
    
    init(pokemonName: String, pokemonImage: String) {
        self.pokemonNameText = pokemonName
        self.pokemonImageUrl = pokemonImage
    }
    
    func getPokemonName() -> String {
        pokemonNameText.capitalizingFirstLetter()
    }
    
    func getPokemonImageUrl() -> String {
        pokemonImageUrl
    }
    
}
