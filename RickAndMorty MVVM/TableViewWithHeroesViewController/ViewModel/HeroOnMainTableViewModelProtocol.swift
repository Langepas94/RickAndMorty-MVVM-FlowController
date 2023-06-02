//
//  HeroOnMainTableViewModelProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

protocol HeroOnMainTableViewModelProtocol {
    
    var model: [HeroModelOnTableProtocol]? { get set }
    
    var filteredModel: [HeroModelOnTableProtocol]? { get set }
    
    var bindClosure: ((Bool) -> Void)? { get set }
    var bindClosureFiltered: ((Bool) -> Void)? { get set }
    
    func nextPage()
    
    var passData: ((HeroModelOnTableProtocol) -> Void)? { get set }
    
    func goToDetailScreen(index: Int)
    
    var currentPage: Int { get set }
    
    var pagesIsCancel: Bool { get set}
    
    var maximumPage: Int? { get }
    
    func getFiltered(phrase: String)
    
    var isFiltered: Bool { get set }
    
    func zeroFiltered()
    
    var flowController: FlowController? { get set }
}
