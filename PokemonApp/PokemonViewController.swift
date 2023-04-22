//
//  ViewController.swift
//  PokemonApp
//
//  Created by Wesley White on 19/04/2023.
//

import UIKit

class PokemonViewController: UIViewController {
    
    enum Constants {
        static let pokemonListUrl = "https://pokeapi.co/api/v2/pokemon/"
    }
    
    let pokemonNetworkManager = PokemonNetworkManager()
    var pokemonCharacters = [PokemonCharacter]()
    var pokemonCharacterStats = [PokemonCharacterStats]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPokemonData()
    }
    
    private func fetchPokemonData() {
        pokemonNetworkManager.pokemonListRequest(with: Constants.pokemonListUrl) { pokemonList in
            for pokemon in pokemonList {
                self.pokemonCharacters.append(PokemonCharacter(name: pokemon.name, url: pokemon.url))
            }
            self.fetchPokemonStats()
        }
    }
    
    private func fetchPokemonStats() {
        print (self.pokemonCharacters)
        for pokemonCharacter in pokemonCharacters {
            self.pokemonNetworkManager.pokemonStatsRequest(with: pokemonCharacter.url) { pokemonStats in
              
                
                self.pokemonCharacterStats.append(PokemonCharacterStats(name: pokemonStats.forms.first?.name ?? "", image: pokemonStats.sprites.front_default ?? ""))
                print (self.pokemonCharacterStats)
            }
        }
    }
}
