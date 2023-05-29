//
//  DetailInfoViewProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation
import UIKit

protocol DetailInfoViewControllerProtocol {
    var heroName: UILabel { get set }
    var heroImage: UIImageView { get set }
    var status: UILabel { get set }
    var species: UILabel { get set }
    var type: UILabel { get set }
    var gender: UILabel { get set }
    var origin: UILabel { get set }
    var location: UILabel { get set }
}
