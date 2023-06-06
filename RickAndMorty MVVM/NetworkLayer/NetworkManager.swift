//
//  NetworkManager.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 02.06.2023.
//

import Foundation
import Combine

class NetworkManager: NetworkServiceProtocol {
    static func baseURL() -> String {
        "https://rickandmortyapi.com/api/"
    }
    
    func loadAllHeroes(page: Int) -> AnyPublisher<NetworkHeroesDataModel, Error> {
        var urlComonents = URLComponents(string: NetworkManager.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        
        guard var url = completedURL else { return
            Fail(error: NSError(domain: "Error", code: 0)
            )
            .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkHeroesDataModel.self, decoder: JSONDecoder())
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
    }
    
    func loadFilteredHeroes(page: Int, phrase: String) -> AnyPublisher<NetworkHeroesDataModel, Error> {
        var urlComonents = URLComponents(string: NetworkManager.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "name", value: "\(phrase)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        
        guard var url = completedURL else { return
            Fail(error: NSError(domain: "Error", code: 0))
            .eraseToAnyPublisher()
        }
        
        guard var url = completedURL else { return
            Fail(error: NSError(domain: "Error", code: 0))
            .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkHeroesDataModel.self, decoder: JSONDecoder())
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
    }
}



