//
//  PokemonCollectionViewCell.swift
//  PokemonApp
//
//  Created by Wesley White on 22/04/2023.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configure(pokemonName: String, image: String) {
        pokemonNameLabel.text = pokemonName.capitalizingFirstLetter()
        setImage(from: image)
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
