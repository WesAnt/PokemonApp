//
//  PokemonDetailsViewModel.swift
//  PokemonApp
//
//  Created by Wesley White on 23/04/2023.
//

import Foundation

struct PokemonDetailsViewModel {
    
    //MARK: - Private properties
    private var pokemonName: String
    private var pokemonImageUrl: String
    private var pokemonHeight: Int
    private var pokemonWeight: Int
    
    //Mark: - Init
    init(pokemonImageUrl: String,
                   pokemonName: String,
                   pokemonHeight: Int,
                   pokemonWeight: Int) {
        self.pokemonName = pokemonName
        self.pokemonHeight = pokemonHeight
        self.pokemonWeight = pokemonWeight
        self.pokemonImageUrl = pokemonImageUrl
    }
    
    //Mark: - Getter funcs
    func getPokemonName() -> String {
        pokemonName.capitalizingFirstLetter()
    }
    
    func getPokemonImageUrl() -> String {
        pokemonImageUrl
    }
    
    func getPokemonHeight() -> Int {
        pokemonHeight
    }
    
    func getPokemonWeight() -> Int {
        pokemonWeight
    }
}
