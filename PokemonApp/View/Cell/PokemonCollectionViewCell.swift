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
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var viewModel: PokemonCollectionViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(viewModel: PokemonCollectionViewCellViewModel) {
        self.viewModel = viewModel
        setup()
    }
    
    func setup( ){
        pokemonNameLabel.text = viewModel?.getPokemonName()
        setImage(from: viewModel?.getPokemonImageUrl() ?? "")
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
