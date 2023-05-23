//
//  MainTableHeroesCellProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 23.05.2023.
//

import Foundation
import UIKit

protocol MainTableHeroesCellProtocol {
    static var id: String { get set }
    var name: UILabel { get set }
    var image: UIImageView { get set }
//    var status: String? { get set }
//    var species: String? { get set }
//    var type: String? { get set }
//    var gender: String? { get set }
//    var origin: Location? { get set }
//    var location: Location? { get set }
//    var image: String? { get set }
//    var episode: [String]? { get set }
//    var url: String? { get set }
//    var created: String? { get set }
    func configureCell(with data: HeroModelOnTableProtocol?)
    func setupUI()
}

