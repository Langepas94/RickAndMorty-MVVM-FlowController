//
//  MainTableWithHeroesViewControllerProtocol.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 02.06.2023.
//

import Foundation
import UIKit.UITableView

protocol MainTableWithHeroesViewControllerProtocol:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: HeroOnMainTableViewModelProtocol { get set }
    var table: UITableView { get set }
}
