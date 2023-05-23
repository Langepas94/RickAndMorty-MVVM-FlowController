//
//  HeroModelOnTable.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

struct HeroModelOnTable: HeroModelOnTableProtocol {
    
    var name: String
    
    init(data: CharacterResult) {
        self.name = data.name ?? ""
    }
    
    internal init(name: String) {
        self.name = name
    }
}
