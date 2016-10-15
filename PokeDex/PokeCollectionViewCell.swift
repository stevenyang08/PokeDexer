//
//  PokeCollectionViewCell.swift
//  Poke'Dex
//
//  Created by Steven Yang on 9/24/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var thumbImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var pokemon: Pokemon!
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      layer.cornerRadius = 5.0
  }
  
  func configureCell(_ pokemon: Pokemon) {
      self.pokemon = pokemon
      nameLabel.text = self.pokemon.name.capitalized
      thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
  }
  
}
