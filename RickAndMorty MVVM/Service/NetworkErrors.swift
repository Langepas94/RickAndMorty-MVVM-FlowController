//
//  NetworkErrors.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 15.06.2023.
//

import Foundation

enum NetworkErrors: Error {
    case notNetworkAvailable
    case incorrectURL
    case unknownError
}
