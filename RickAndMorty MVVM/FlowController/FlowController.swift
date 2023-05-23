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

final class FlowController: FlowControllerProtocol {
    var navigationController: UINavigationController
    
    func loadingMainScreen() {
        goToMainScreen()
    }
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToMainScreen() {
        let vc = MainTableWithHeroesViewController()
        let viewModel = HeroOnMainTableViewModel()
        viewModel.flowController = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToDetailScreen() {
        let vc = DetailInfoViewController()
//        navigationController.pushViewController(vc, animated: true)
        navigationController.present(vc, animated: true)
    }

}
