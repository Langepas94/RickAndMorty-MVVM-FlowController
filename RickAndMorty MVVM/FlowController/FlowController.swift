//
//  FlowController.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import Foundation
import UIKit

protocol MainTableWithHeroesViewControllerProtocol:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: HeroOnMainTableViewModelProtocol? { get set }
    var table: UITableView { get set }
    func bindViewModel()
}

final class FlowController {
    var mainVC: MainTableWithHeroesViewControllerProtocol?
    
    
    init() {
        self.mainVC = MainTableWithHeroesViewController()
    }
}
