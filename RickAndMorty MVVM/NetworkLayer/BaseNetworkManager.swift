//
//  NetworkManager.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

class BaseNetworkManager: NetworkManagerBaseProtocol {
    
    static func baseURL() -> String {
        "https://rickandmortyapi.com/api/"
    }
    
}

class NetworkManager: BaseNetworkManager {
    
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, Error>) -> Void) {
        
        var urlComonents = URLComponents(string: BaseNetworkManager.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        
        guard var url = completedURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(NetworkHeroesDataModel.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(error.localizedDescription as! Error))
            }
        }
        
        task.resume()
        
    }
    
    
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping(Result<NetworkHeroesDataModel?, Error>) -> Void) {
        
        var urlComonents = URLComponents(string: BaseNetworkManager.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "name", value: "\(phrase)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        
        guard var url = completedURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(NetworkHeroesDataModel.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(error.localizedDescription as! Error))
            }
        }
        
        task.resume()
        
    }
    
    
}



