//
//  PokemonCollectionViewCellViewModel.swift
//  PokemonApp
//
//  Created by Wesley White on 23/04/2023.
//

import Foundation

struct PokemonCollectionViewCellViewModel {
    //MARK: - Private Properties
    private var pokemonNameText: String
    private var pokemonImageUrl: String
    
    //MARK: - Init
    init(pokemonName: String, pokemonImageUrl: String) {
        self.pokemonNameText = pokemonName
        self.pokemonImageUrl = pokemonImageUrl
    }
    
    //MARK: - Getter funcs
    func getPokemonName() -> String {
        pokemonNameText.capitalizingFirstLetter()
    }
    
    func getPokemonImageUrl() -> String {
        pokemonImageUrl
    }
    
}
