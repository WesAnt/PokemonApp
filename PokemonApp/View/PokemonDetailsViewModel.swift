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
    var getPokemonName: String {
        "Name: " + pokemonName.capitalizingFirstLetter()
    }
    
    var getPokemonImageUrl: String {
        pokemonImageUrl
    }
    
    var getPokemonHeight: String {
        "Height: \(Float(pokemonHeight*10))cm"
    }
    
    var getPokemonWeight: String {
        "Weight: \(Float(pokemonWeight/10))kg"
    }
}
