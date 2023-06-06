//
//  NetworkManagerProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import Combine

enum FetchedData: String {
    case allCharacters = "character"
    case location = "location"
    case episode = "episode"
}

protocol NetworkServiceProtocol {
    
    static func baseURL() -> String
    
    func loadAllHeroes(page: Int) -> AnyPublisher<NetworkHeroesDataModel, Error>
    
    func loadFilteredHeroes(page: Int, phrase: String) -> AnyPublisher<NetworkHeroesDataModel, Error>
}
