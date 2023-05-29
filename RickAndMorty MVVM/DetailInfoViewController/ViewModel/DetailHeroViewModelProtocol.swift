//
//  DetailHeroViewModelProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation

protocol DetailHeroViewModelProtocol {
    var model: DetailHeroModel? { get set }
    func configureData(_ controller: DetailInfoViewControllerProtocol )
    
}
