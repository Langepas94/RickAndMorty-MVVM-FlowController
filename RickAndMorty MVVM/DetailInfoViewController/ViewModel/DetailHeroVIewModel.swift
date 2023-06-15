//
//  DetailHeroVIewModel.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 29.05.2023.
//

import Foundation
import Combine

final class DetailHeroViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    enum State: Equatable {
        case loadScreen
    }
    
    enum Event {
        case onAppear
    }
    
    var model: DetailHeroModel?
    
    // MARK: - Private properties
    
    @Published private(set) var state: State = .loadScreen
    
    // MARK: - Public methods
    
    func send(event: Event) {
        
        switch event {
            
        case .onAppear:
            self.state = .loadScreen
        }
    }

}
