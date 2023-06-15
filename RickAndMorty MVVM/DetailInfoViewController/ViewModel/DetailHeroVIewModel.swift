//
//  DetailHeroVIewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation
import Combine

final class DetailHeroViewModel {
    
    // MARK: - Public properties
    
    enum State: Equatable {
        case idle
        case loadScreen
    }
    
    enum Event {
        case onAppear
    }
    
    var model: DetailHeroModel?
    
    @Published private(set) var state: State = .idle
    
    // MARK: - Public methods
    
    func send(event: Event) {
        
        switch event {
            
        case .onAppear:
            self.state = .loadScreen
        }
    }

}
