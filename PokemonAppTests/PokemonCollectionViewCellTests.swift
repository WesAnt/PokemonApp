//
//  PokemonCollectionViewCellTests.swift
//  PokemonAppTests
//
//  Created by Wesley White on 23/04/2023.
//

import XCTest
@testable import PokemonApp

class PokemonCollectionViewCellTests: XCTestCase {

    //MARK: - Properties
    var viewModel: PokemonCollectionViewCellViewModel!
    var pokemonName: String = ""
    var pokemonImageUrl: String = ""
    
    //MARK: - Base Class Overrides
    override func setUp() {
        super.setUp()
        pokemonName = "Bulbasaur"
        pokemonImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        viewModel = PokemonCollectionViewCellViewModel(pokemonName: pokemonName,
                                                       pokemonImageUrl: pokemonImageUrl)
    }

    override func tearDown() {
        viewModel = nil
    }

    //MARK:- Tests
    func test_init_setsCorrectStrings() {
        XCTAssertEqual(pokemonName, "Bulbasaur")
        XCTAssertEqual(pokemonImageUrl, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
}
