//
//  HeroOnMainTableViewModelProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation

protocol HeroOnMainTableViewModelProtocol {
//    var state: HeroOnMainTableViewModelStates { get set }
//    func updateViewState()
    var model: [HeroModelOnTableProtocol]? { get set }
    func fetchData()
    var bindClosure: (([HeroModelOnTableProtocol]?, Bool) -> Void)? { get set }
    func nextPage()
    var currentPage: Int { get set }
    var pagesIsCancel: Bool { get set}
    var maximumPage: Int? { get }
}
