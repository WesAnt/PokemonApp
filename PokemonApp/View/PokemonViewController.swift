//
//  ViewController.swift
//  PokemonApp
//
//  Created by Wesley White on 19/04/2023.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: - Constants
    enum Constants {
        static let pokemonListUrl = "https://pokeapi.co/api/v2/pokemon?limit=151"
        static let pokemonImageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
        static let title = "POKEMON!"
    }
    
    //MARK: - Properties
    private let pokemonNetworkManager = PokemonNetworkManager()
    private var pokemonEntries = [PokemonEntry]()
    private var pokemonImageUrl: [String] = []
    private var pokemonStats = [PokemonStats]()

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PokemonViewController.createLayout())
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        fetchPokemonData()
        configureCollectionView()
        configureCollectionViewConstraints()
        showActivityIndicator()
    }
    
    //Mark: - Fetch pokemon data API
    private func fetchPokemonData() {
        pokemonNetworkManager.pokemonListRequest(with: Constants.pokemonListUrl) { pokemonList in
            self.pokemonEntries = pokemonList
            self.activityView.stopAnimating()
            self.setupPokemonImageUrlArray()
            self.collectionView.reloadData()
        }
    }
    
    private func setupPokemonImageUrlArray() {
        for index in 1...pokemonEntries.count {
            pokemonImageUrl.append(Constants.pokemonImageBaseUrl + "\(index)" + ".png")
        }
    }
    
    private func showActivityIndicator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
}

//MARK: - Collection View Layout
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

//MARK: - UICollectionViewDelegate
extension PokemonViewController: UICollectionViewDelegate {
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonCollectionViewCell.nib, forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        collectionView.layer.borderWidth = 5.0
        collectionView.layer.borderColor = .init(red: 50/255, green: 159/255, blue: 190/255, alpha: 1)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private func configureCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

//MARK: - UICollectionViewDataSource
extension PokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell",
                                                            for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(viewModel: PokemonCollectionViewCellViewModel(pokemonName: pokemonEntries[indexPath.row].name,
                                                                pokemonImageUrl: pokemonImageUrl[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonDetailsViewController = storyboard?.instantiateViewController(identifier: "PokemonDetailsViewController") as! PokemonDetailsViewController
        
        self.pokemonNetworkManager.pokemonStatsRequest(with: pokemonEntries[indexPath.row].url) { pokemonStats in
            pokemonDetailsViewController.bind(viewModel: PokemonDetailsViewModel(pokemonImageUrl: self.pokemonImageUrl[indexPath.row],
                                                                                 pokemonName: pokemonStats.name,
                                                                                 pokemonHeight: pokemonStats.height,
                                                                                 pokemonWeight: pokemonStats.weight))
        }
        self.navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }
}
