//
//  PokemonDetailsViewController.swift
//  PokemonApp
//
//  Created by Wesley White on 23/04/2023.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet private var pokemonNameLabel: UILabel!
    @IBOutlet private var pokemonHeightLabel: UILabel!
    @IBOutlet private var pokemonWeightLabel: UILabel!
    
    //MARK: - Properties
    private var viewModel: PokemonDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Internal funcs
    func bind(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
        setup()
    }
    
    //MARK: - Private funcs
    private func setup() {
        title = "Pokemon Details"
        view.backgroundColor = .init(red: 50/255, green: 159/255, blue: 190/255, alpha: 1)
        pokemonNameLabel.text = viewModel?.getPokemonName()
        pokemonHeightLabel.text = "Height: \(viewModel?.getPokemonHeight() ?? 0) ft"
        pokemonWeightLabel.text = "Weight: \(viewModel?.getPokemonWeight() ?? 0) Kg"
        setImage(from: viewModel?.getPokemonImageUrl() ?? "")
    }
    
    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        }
    }
}
