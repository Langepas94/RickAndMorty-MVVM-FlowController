//
//  NetworkManager.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 02.06.2023.
//

import Foundation
import Alamofire

class NetworkServiceImpl: HeroNetworkService {
    static func baseURL() -> String {
        "https://rickandmortyapi.com/api/"
    }
    
    // MARK: - Get all characters
    
    func getAllCharacters(page: Int, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
        
        let mainURL = NetworkServiceImpl.baseURL() + FetchedData.allCharacters.rawValue
        let parameters: [String : String] = [
            "page" : "\(page)"
        ]
        
        AF.request(mainURL, parameters: parameters) { request in
            request.timeoutInterval = 10
        }
        .validate()
        .responseDecodable(of: NetworkHeroesDataModel.self) { response in
            if let error = response.error {
                if error.responseCode == 404 {
                    print("incorrect URl")
                    completion(.failure(.incorrectURL))
                } else {
                    print("No network")
                    completion(.failure(.notNetworkAvailable))
                }
            } else {
                switch response.result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    print("fuf")
                    completion(.failure(.notNetworkAvailable))
                }
            }
        }
    }
    
    // MARK: - Get filtered characters
    
    func getFilteredCharacters(page: Int, phrase: String, completion: @escaping(Result<NetworkHeroesDataModel?, NetworkErrors>) -> Void) {
        
        let mainURL = NetworkServiceImpl.baseURL() + FetchedData.allCharacters.rawValue
        let parameters: [String : String] = [
            "page" : "\(page)",
            "name" : "\(phrase)"
        ]
        AF.request(mainURL, parameters: parameters) { request in
            request.timeoutInterval = 10
        }
        .validate()
        .responseDecodable(of: NetworkHeroesDataModel.self) { response in
            if let error = response.error {
                if error.responseCode == 404 {
                    print("incorrect URl")
                    completion(.failure(.incorrectURL))
                } else {
                    print("No network")
                    completion(.failure(.notNetworkAvailable))
                }
            } else {
                switch response.result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    print("fuf")
                    completion(.failure(.notNetworkAvailable))
                }
            }
        }
    }
}



