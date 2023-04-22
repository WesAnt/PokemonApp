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
    var pokemonCharacterStats = [PokemonCharacterStats]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PokemonViewController.createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonData()
        configureCollectionView()
        configureCollectionViewConstraints()
    }
    
    private func fetchPokemonData() {
        pokemonNetworkManager.pokemonListRequest(with: Constants.pokemonListUrl) { pokemonList in
            for pokemon in pokemonList {
                self.pokemonCharacters.append(PokemonCharacter(name: pokemon.name, url: pokemon.url))
                self.fetchPokemonStats()
            }
        }
    }
    
    private func fetchPokemonStats() {
        print (self.pokemonCharacters)
        for pokemonCharacter in pokemonCharacters {
            self.pokemonNetworkManager.pokemonStatsRequest(with: pokemonCharacter.url) { pokemonStats in
                self.pokemonCharacterStats.append(PokemonCharacterStats(name: pokemonStats.forms.first?.name ?? "", image: pokemonStats.sprites.front_default ?? ""))
            }
        }
    }
}

extension PokemonViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                            widthDimension: .fractionalWidth(1),
                                            heightDimension: .fractionalHeight(1)))
        let inset: CGFloat = 2.5
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(2/5)),
                                                        subitem: item,
                                                        count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension PokemonViewController: UICollectionViewDelegate {
    private func configureCollectionView() {
        let nib = UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(nib, forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        collectionView.layer.borderWidth = 5.0
        collectionView.layer.borderColor = UIColor.blue.cgColor
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.backgroundColor = .black
    }
}

extension PokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath)
        return cell
    }
}
