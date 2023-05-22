//
//  HeroOnMainTableViewModelProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

protocol HeroOnMainTableViewModelProtocol {
    var model: [HeroModelOnTableProtocol] { get set }
    var labels: [String] { get set }
    func setName()
}
