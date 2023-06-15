//
//  NetworkService.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 14.06.2023.
//

import Foundation

enum FetchedData: String {
    case allCharacters = "character"
    case location = "location"
    case episode = "episode"
}

protocol HeroNetworkService {
    static func baseURL() -> String
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void)
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void)
}
