//
//  DetailHeroModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation

struct DetailHeroModel {
    
    var name: String
    
    var image: String
    
    var status: String
    
    var species: String
    
    var type: String 
    
    var gender: String
    
    var origin: Location
    
    var location: Location
    
    internal init(name: String, image: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location) {
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
    }
    
    init(data: HeroModelOnTable) {
        self.name = data.name
        self.image = data.image
        self.status = data.status
        self.species = data.species
        self.type = data.type
        self.gender = data.gender
        self.origin = data.origin
        self.location = data.location
    }
    
}
