//
//  PokemonDetailsViewModelTests.swift
//  PokemonAppTests
//
//  Created by Wesley White on 23/04/2023.
//

import XCTest
@testable import PokemonApp

class PokemonDetailsViewModelTests: XCTestCase {

    //MARK: - Properties
    var viewModel: PokemonDetailsViewModel!
    var pokemonName: String = ""
    var pokemonImageUrl: String = ""
    var pokemonHeight = 0
    var pokemonWeight = 0
    
    //MARK: - Base Class Overrides
    override func setUp() {
        super.setUp()
        pokemonName = "Bulbasaur"
        pokemonImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        pokemonHeight = 7
        pokemonWeight = 60
        viewModel = PokemonDetailsViewModel(pokemonImageUrl: pokemonImageUrl,
                                            pokemonName: pokemonName,
                                            pokemonHeight: pokemonHeight,
                                            pokemonWeight: pokemonWeight)
    }

    override func tearDown() {
        viewModel = nil
    }

    //MARK:- Tests
    func test_init_setsCorrectStrings() {
        XCTAssertEqual(viewModel.getPokemonName(), "Name: Bulbasaur")
        XCTAssertEqual(viewModel.getPokemonImageUrl(), "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        XCTAssertEqual(viewModel.getPokemonHeight(), "Height: 70.0cm")
        XCTAssertEqual(viewModel.getPokemonWeight(), "Weight: 6.0kg")
    }

}
