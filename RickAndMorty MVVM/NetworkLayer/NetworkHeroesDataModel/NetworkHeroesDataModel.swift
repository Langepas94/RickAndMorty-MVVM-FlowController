//
//  NetworkHeroesDataModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

struct NetworkHeroesDataModel: Decodable {
    let info: Info?
    let results: [CharacterResult]?
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct CharacterResult: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}


struct Location: Decodable {
    let name: String?
    let url: String?
}
