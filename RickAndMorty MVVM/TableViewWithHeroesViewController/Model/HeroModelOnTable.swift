//
//  HeroModelOnTable.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

struct HeroModelOnTable: HeroModelOnTableProtocol {
    
    var image: String
    var name: String
    
    init(data: CharacterResult) {
        self.name = data.name ?? ""
        self.image = data.image ?? ""
    }
    
    internal init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
