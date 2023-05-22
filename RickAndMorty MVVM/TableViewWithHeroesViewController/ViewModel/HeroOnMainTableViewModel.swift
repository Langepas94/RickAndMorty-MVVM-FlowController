//
//  HeroOnMainTableViewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

class HeroOnMainTableViewModel: HeroOnMainTableViewModelProtocol {
    
    var model: [HeroModelOnTableProtocol]
    
    var labels = [String]()
    
    func setName() {
        self.labels = model.map({ model in
            model.name
        })
    }
    
     init(model: [HeroModelOnTableProtocol], labels: [String] = [String]()) {
        self.model = model
        self.labels = labels
    }
    
}
