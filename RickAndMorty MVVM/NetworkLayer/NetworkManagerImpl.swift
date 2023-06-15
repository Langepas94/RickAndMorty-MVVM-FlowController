//
//  NetworkManager.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 02.06.2023.
//

import Foundation

enum NetworkErrors: Error {
    case notNetworkAvailable
}

class NetworkManagerImpl: HeroNetworkService {
    static func baseURL() -> String {
        "https://rickandmortyapi.com/api/"
    }
    
    // MARK: - Get all characters
    
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, Error>) -> Void) {
        var urlComonents = URLComponents(string: NetworkManagerImpl.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        guard var url = completedURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(NetworkErrors.notNetworkAvailable))
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
    
    // MARK: - Get filtered characters
    
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping(Result<NetworkHeroesDataModel?, Error>) -> Void) {
        var urlComonents = URLComponents(string: NetworkManagerImpl.baseURL() + FetchedData.allCharacters.rawValue)
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



