//
//  HeroModelOnTableProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

protocol HeroModelOnTableProtocol {
    
    var name: String { get set}
    init(data: CharacterResult)
}
