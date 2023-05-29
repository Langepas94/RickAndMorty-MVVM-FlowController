//
//  DetailHeroModelProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation

protocol DetailHeroModelProtocol {
    var name: String { get set}
    var image: String { get set}
    var status: String { get set }
    var species: String { get set }
    var type: String { get set }
    var gender: String { get set }
    var origin: Location { get set }
    var location: Location { get set }
}
