//
//  NetworkManagerProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

enum FetchedData: String {
    case allCharacters = "character"
    case location = "location"
    case episode = "episode"
}

protocol NetworkServiceProtocol {
    
    static func baseURL() -> String
    
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, Error>) -> Void)
    
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping(Result<NetworkHeroesDataModel?, Error>) -> Void)
}
