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

protocol NetworkManagerBaseProtocol {
    static func baseURL() -> String
}
