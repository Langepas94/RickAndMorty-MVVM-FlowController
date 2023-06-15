//
//  MockNetworkServiceImpl.swift
//  RickAndMorty MVVMTests
//
//  Created by Artem on 15.06.2023.
//

import Foundation
@testable import RickAndMorty_MVVM

class MockNetworkServiceImpl: HeroNetworkService {
    
    static func baseURL() -> String {
        return ""
    }
    
    var getAllCharactersMock: ((Result<RickAndMorty_MVVM.NetworkHeroesDataModel?, NetworkErrors>) -> Void)!
    
    var getFilteredCharactersMock: ((Result<RickAndMorty_MVVM.NetworkHeroesDataModel?, NetworkErrors>) -> Void)!
    
    let model: NetworkHeroesDataModel? = NetworkHeroesDataModel(info: Info(count: 1, pages: 1, next: "", prev: ""), results: [CharacterResult(id: 1, name: "", status: "", species: "", type: "", gender: "", origin: Location(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [""], url: "", created: "")])
    
    func getAllCharacters(page: Int, completion: @escaping (Result<RickAndMorty_MVVM.NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
            self.getAllCharactersMock = completion
    }
    
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping (Result<RickAndMorty_MVVM.NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
        getFilteredCharactersMock = completion
    }
    
    func successLoadAllCharacters() {
        self.getAllCharactersMock(Result.success(self.model))
    }
    
    func failLoadAllCharacters(error: NetworkErrors) {
        getAllCharactersMock(Result.failure(error))
    }
    
    func successGetFilteredCharacters() {
        getFilteredCharactersMock(Result.success(model))
    }
    
    func failGetFilteredCharacters(error: NetworkErrors) {
        getFilteredCharactersMock(Result.failure(error))
    }
}
