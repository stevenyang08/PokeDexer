//
//  PokemonDetailViewController.swift
//  Poke'Dex
//
//  Created by Steven Yang on 9/24/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var pokemonDescription: UILabel!
  @IBOutlet weak var pokeIdLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var totalStatsLabel: UILabel!
  @IBOutlet weak var attackLabel: UILabel!
  @IBOutlet weak var hpLabel: UILabel!
  @IBOutlet weak var defenseLabel: UILabel!
  @IBOutlet weak var speedLabel: UILabel!
  @IBOutlet weak var spAttackLabel: UILabel!
  @IBOutlet weak var spDefenseLabel: UILabel!
  @IBOutlet weak var currentEvoImage: UIImageView!
  @IBOutlet weak var nextEvoImage: UIImageView!
  @IBOutlet weak var evoLabel: UILabel!
  
  var pokemon: Pokemon!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      
      nameLabel.text = pokemon.name.capitalized
      let img = UIImage(named: "\(pokemon.pokedexId)")
      pokemonImage.image = img
      currentEvoImage.image = img
      pokeIdLabel.text = "\(pokemon.pokedexId)"
      
      
      pokemon.downloadPokemonDetails { 
          // Only be called after network call is complete
          self.updateUI()
          
      }
  }
  
  func updateUI() {
      pokemonDescription.text = pokemon.description
      typeLabel.text = pokemon.type
      heightLabel.text = pokemon.height
      weightLabel.text = pokemon.weight
      totalStatsLabel.text = pokemon.totalStats
      hpLabel.text = pokemon.hp
      attackLabel.text = pokemon.attack
      defenseLabel.text = pokemon.defense
      speedLabel.text = pokemon.speed
      spAttackLabel.text = pokemon.spAttack
      spDefenseLabel.text = pokemon.spDefense
      
      if pokemon.nextEvolutionId == "" {
          
          evoLabel.text = "No Evolutions"
          nextEvoImage.isHidden = true
      } else {
          
          nextEvoImage.isHidden = false
          nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
          let string = "\(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
          evoLabel.text = string
      }
      
  }
  
  @IBAction func backButtonTapped(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
  }
  
}
