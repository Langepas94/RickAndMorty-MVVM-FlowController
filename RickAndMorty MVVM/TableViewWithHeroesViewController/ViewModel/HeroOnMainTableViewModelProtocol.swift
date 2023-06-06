//
//  HeroOnMainTableViewModelProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import Combine

protocol HeroOnMainTableViewModelProtocol {
    
    var model: [HeroModelOnTableProtocol]? { get set }
    
    var filteredModel: [HeroModelOnTableProtocol]? { get set }
    
    func nextPage()
    
    func goToDetailScreen(index: Int)
    
    var currentPage: Int { get set }
    
    var pagesIsCancel: Bool { get set}
    
    var maximumPage: Int? { get }
    
    var isFiltered: Bool { get set }
    
    func zeroFiltered()
    
    var flowController: FlowController? { get set }
    
    var updatePublisher: PassthroughSubject<Void, Never> { get set }
    
    var detailScreenPublisher: PassthroughSubject<HeroModelOnTableProtocol, Never> { get set } 
    
    func getFiltered(phrase: String)
}
