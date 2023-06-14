//
//  HeroModelOnTable.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation


struct HeroModelOnTable: Equatable {
    static func == (lhs: HeroModelOnTable, rhs: HeroModelOnTable) -> Bool {
        lhs.description == rhs.description && lhs.name == rhs.name && lhs.image == rhs.image
    }
    
    
    var description: String
    
    var setIshiddenErrorView: Bool = true
    
    var image: String
    
    var name: String
    
    var status: String
    
    var species: String
    
    var type: String
    
    var gender: String
    
    var origin: Location
    
    var location: Location
    
    init(data: CharacterResult) {
        self.name = data.name ?? ""
        self.image = data.image ?? ""
        self.status = data.status ?? ""
        self.species = data.species ?? ""
        self.type = data.type ?? ""
        self.gender = data.gender ?? ""
        self.origin = data.origin ?? Location(name: "", url: "")
        self.location = data.location ?? Location(name: "", url: "")
        self.description = "\(species) - \(status)"
    }

    init(image: String, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, description: String) {
        self.image = image
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.description = description
    }
}
