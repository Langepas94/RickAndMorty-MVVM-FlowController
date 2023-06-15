//
//  NetworkManager.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 02.06.2023.
//

import Foundation

class NetworkServiceImpl: HeroNetworkService {
    static func baseURL() -> String {
        "https://rickandmortyapi.com/api/"
    }
    
    // MARK: - Get all characters
    
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
        var urlComonents = URLComponents(string: NetworkServiceImpl.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        guard let url = completedURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(error?.localizedDescription as! NetworkErrors))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(NetworkHeroesDataModel.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(error.localizedDescription as! NetworkErrors))
            }
        }
        task.resume()
    }
    
    // MARK: - Get filtered characters
    
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
        var urlComonents = URLComponents(string: NetworkServiceImpl.baseURL() + FetchedData.allCharacters.rawValue)
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "name", value: "\(phrase)")]
        urlComonents?.queryItems = queryItems
        let completedURL = urlComonents?.url
        guard let url = completedURL else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(error?.localizedDescription as! NetworkErrors))
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(NetworkHeroesDataModel.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(error.localizedDescription as! NetworkErrors))
            }
        }
        task.resume()
    }
}



