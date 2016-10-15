//
//  Pokemon.swift
//  Poke'Dex
//
//  Created by Steven Yang on 9/24/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
  private var _name: String!
  private var _pokedexId: Int!
  private var _description: String!
  private var _type: String!
  private var _height: String!
  private var _weight: String!
  private var _hp: String!
  private var _attack: String!
  private var _defense: String!
  private var _speed: String!
  private var _spAttack: String!
  private var _spDefense: String!
  private var _totalStats: String!
  private var _nextEvolutionText: String!
  private var _nextEvolutionName: String!
  private var _nextEvolutionId: String!
  private var _nextEvolutionLevel: String!
  private var _pokemonURL: String!
  
  var name: String {
      
      return _name
  }
  
  var pokedexId: Int {
      
      return _pokedexId
  }
  
  var description: String {
      if _description == nil {
          _description = ""
      }
      return _description
  }
  
  var type: String {
      if _type == nil {
          _type = ""
      }
      return _type
  }
  
  var height: String {
      if _height == nil {
          _height = ""
      }
      return _height
  }
  
  var weight: String {
      if _weight == nil {
          _weight = ""
      }
      return _weight
  }
  
  var hp: String {
      if _hp == nil {
          _hp = ""
      }
      return _hp
  }
  
  var attack: String {
      if _attack == nil {
          _attack = ""
      }
      return _attack
  }
  
  var defense: String {
      if _defense == nil {
          _defense = ""
      }
      return _defense
  }
  
  var speed: String {
      if _speed == nil {
          _speed = ""
      }
      return _speed
  }
  
  var spAttack: String {
      if _spAttack == nil {
          _spAttack = ""
      }
      return _spAttack
  }
  
  var spDefense: String {
      if _spDefense == nil {
          _spDefense = ""
      }
      return _spDefense
  }

  var totalStats: String {
    if _totalStats == nil {
      return ""
    }
    return _totalStats
  }

  var nextEvolutionText: String {
      if _nextEvolutionText == nil {
          _nextEvolutionText = ""
      }
      return _nextEvolutionText
  }
  
  var nextEvolutionName: String {
      if _nextEvolutionName == nil {
          _nextEvolutionName = ""
      }
      return _nextEvolutionName
  }
  
  var nextEvolutionId: String {
      if _nextEvolutionId == nil {
          _nextEvolutionId = ""
      }
      return _nextEvolutionId
  }
  
  var nextEvolutionLevel: String {
      if _nextEvolutionLevel == nil {
          _nextEvolutionLevel = ""
      }
      return _nextEvolutionLevel
  }
  
  init(name: String, pokedexId: Int) {
      
      self._name = name
      self._pokedexId = pokedexId
      
      self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
  }
  
  func downloadPokemonDetails(completed: @escaping DownloadComplete) {
      Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
          if let dict = response.result.value as? Dictionary <String, AnyObject> {
              
              if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                  if let name = types[0]["name"] {
                      self._type = name.capitalized
                  }
                  
                  if types.count > 1 {
                      for x in 1..<types.count {
                          
                          if let name = types[x]["name"] {
                              self._type! += "/\(name.capitalized)"
                          }
                          
                      }
                  }
                  
              } else {
                  self._type = ""
              }
              
              if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>] , descriptionArray.count > 0 {
                  
                  if let url = descriptionArray[0]["resource_uri"] {
                      
                      let descriptionURL = "\(URL_BASE)\(url)"
                      Alamofire.request(descriptionURL, method: .get).responseJSON(completionHandler: { (response) in
                          
                          if let descriptionDictionary = response.result.value as? Dictionary<String, AnyObject> {
                              
                              if let description = descriptionDictionary["description"] as? String {
                                  
                                  let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                  self._description = newDescription
                              }
                          }
                          
                          completed()
                      })
                  }
              } else {
                  
                  self._description = ""
              }
              
              if let weight = dict["weight"] as? String {
                  self._weight = weight
              }
              
              if let height = dict["height"] as? String {
                  self._height = height
              }
            
              var totalStats: Int = 0
            
              if let hp = dict["hp"] as? Int {
                  totalStats += hp
                  self._hp = "\(hp)"
              }
              
              if let attack = dict["attack"] as? Int {
                  totalStats += attack
                  self._attack = "\(attack)"
              }
              
              if let defense = dict["defense"] as? Int {
                  totalStats += defense
                  self._defense = "\(defense)"
              }
              
              if let speed = dict["speed"] as? Int {
                  totalStats += speed
                  self._speed = "\(speed)"
              }
              
              if let spAttack = dict["sp_atk"] as? Int {
                  totalStats += spAttack
                  self._spAttack = "\(spAttack)"
              }
              
              if let spDefense = dict["sp_def"] as? Int {
                  totalStats += spDefense
                  self._spDefense = "\(spDefense)"
              }
            
              self._totalStats = "\(totalStats)"
              print(self.totalStats)
            
              if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolution.count > 0 {
                  
                  if let nextEvolution = evolution[0]["to"] as? String {
                      
                      if nextEvolution.range(of: "mega") == nil || evolution[0]["level"] != nil {
                          
                          self._nextEvolutionName = nextEvolution
                          if let uri = evolution[0]["resource_uri"] as? String {
                              
                              let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                              let newEvolutionId = newString.replacingOccurrences(of: "/", with: "")
                              self._nextEvolutionId = newEvolutionId
                              
                              if let levelExist = evolution[0]["level"] {
                                  
                                  if let level = levelExist as? Int {
                                      
                                      self._nextEvolutionLevel = "\(level)"
                                  }
                              } else {
                                  
                                  self._nextEvolutionLevel = ""
                              }
                              
                          }
                      }
                      
                  }
                  
                  print(self.nextEvolutionLevel)
                  print(self.nextEvolutionId)
                  print(self.nextEvolutionName)
                  
              }

          }
          completed()
      }
  }
  
  
}
