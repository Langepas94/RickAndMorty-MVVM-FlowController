//
//  DetailHeroModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation

struct DetailHeroModel {
    
    // MARK: - Public properties
    
    var name: String
    var image: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Location
    var location: Location
    
    // MARK: - Init's
    
    init(name: String, image: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location) {
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
    
    init() {
        self.name = "Unknown"
        self.image = "Unknown"
        self.status = "Unknown"
        self.species = "Unknown"
        self.type = "Unknown"
        self.gender = "Unknown"
        self.origin = Location(name: "", url: "")
        self.location = Location(name: "", url: "")
    }
    
}
