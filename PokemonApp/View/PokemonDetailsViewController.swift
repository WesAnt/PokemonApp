//
//  PokemonDetailsViewController.swift
//  PokemonApp
//
//  Created by Wesley White on 23/04/2023.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet private var pokemonNameLabel: UILabel!
    @IBOutlet private var pokemonHeightLabel: UILabel!
    @IBOutlet private var pokemonWeightLabel: UILabel!
    
    private var pokemonName: String?
    private var pokemonImageUrl: String?
    private var pokemonHeight: Int?
    private var pokemonWeight: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Pokemon Details"
        pokemonNameLabel.text = pokemonName?.capitalizingFirstLetter()
        pokemonHeightLabel.text = "Height: \(pokemonHeight ?? 0) ft"
        pokemonWeightLabel.text = "Weight: \(pokemonWeight ?? 0) Kg"
        setImage(from: pokemonImageUrl ?? "")
    }
    
    func configure(pokemonImageUrl: String,
                   pokemonName: String,
                   pokemonHeight: Int,
                   pokemonWeight: Int) {
       
        self.pokemonName = pokemonName
        self.pokemonHeight = pokemonHeight
        self.pokemonWeight = pokemonWeight
        self.pokemonImageUrl = pokemonImageUrl
    }
    
    func setImage(from url: String) {
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
