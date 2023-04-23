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
    var pokemonEntries = [PokemonEntry]()
    var pokemonStats = [PokemonStats]() {
        didSet {
            pokemonStats.sort {
                $0.name  < $1.name
            }
            collectionView.reloadData()
        }
    }

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PokemonViewController.createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "POKEMON"
        fetchPokemonData()
        configureCollectionView()
        configureCollectionViewConstraints()
    }
    
    private func fetchPokemonData() {
        pokemonNetworkManager.pokemonListRequest(with: Constants.pokemonListUrl) { pokemonList in
            self.pokemonEntries = pokemonList
            DispatchQueue.main.async {
                self.fetchPokemonStats()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func fetchPokemonStats() {
        for pokemonCharacter in pokemonEntries {
            self.pokemonNetworkManager.pokemonStatsRequest(with: pokemonCharacter.url) { pokemonStats in
                self.pokemonStats.append(pokemonStats)
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonCollectionViewCell.nib, forCellWithReuseIdentifier: "PokemonCollectionViewCell")
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
        return pokemonStats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(viewModel: PokemonCollectionViewCellViewModel(pokemonName: pokemonStats[indexPath.row].name, pokemonImage: pokemonStats[indexPath.row].sprites.front_default ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonDetailsViewController = storyboard?.instantiateViewController(identifier: "PokemonDetailsViewController") as! PokemonDetailsViewController
        pokemonDetailsViewController.configure(pokemonImageUrl: pokemonStats[indexPath.row].sprites.front_default ?? "", pokemonName: pokemonStats[indexPath.row].name, pokemonHeight: pokemonStats[indexPath.row].height, pokemonWeight: pokemonStats[indexPath.row].weight)
        self.navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
        
    }
}
